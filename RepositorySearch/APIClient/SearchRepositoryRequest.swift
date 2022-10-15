//
//  RepositorySearchClient.swift
//  RepositorySearch
//
//  Created by 董 亜飛 on 2022/09/23.
//

import Foundation
import Alamofire

final class SearchRepositoryRequest {
    static let perPage = 50
    
    func fetchRepositories(query: String, page: Int = 1) async throws -> [Repository] {
        let url = "https://api.github.com/search/repositories?q=\(query)+in:name&sort=stars&per_page=\(SearchRepositoryRequest.perPage)&page=\(page)"
        
        return try await withCheckedThrowingContinuation{ continuation in
            AF.request(url).response { response in
                if response.response?.statusCode != 200 {
                    // ステータスコードが200以外の場合
                    continuation.resume(throwing: APIError.unknownError)
                    return
                }
                
                switch response.result {
                case .success(let data):
                    do {
                        let searchResult = try JSONDecoder().decode(RepositorySearchResult.self, from: data!)
                        
                        if searchResult.items.count == 0 {
                            // レスポンスが空の場合
                            continuation.resume(throwing: APIError.notFound)
                            return
                        }
                        
                        continuation.resume(returning: searchResult.items)
                    } catch {
                        // JSONパースできなかった場合
                        continuation.resume(throwing: APIError.jsonParseError)
                    }
                case .failure(_):
                    continuation.resume(throwing: APIError.unknownError)
                }
            }
        }
    }
}

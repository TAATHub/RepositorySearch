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
        let result: RepositorySearchResult
        
        do {
            result = try await AF.request(url).response()
        } catch {
            throw APIError.unknownError
        }
        
        if result.items.count == 0 {
            // レスポンスが空の場合
            throw APIError.notFound
        }
        
        return result.items
    }
}

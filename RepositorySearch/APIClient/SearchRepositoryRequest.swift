//
//  RepositorySearchClient.swift
//  RepositorySearch
//
//  Created by 董 亜飛 on 2022/09/23.
//

import Foundation

final class SearchRepositoryRequest {
    static let perPage = 50
    
    func fetchRepositories(query: String, page: Int = 1) async throws -> [Repository] {
        // リポジトリ名で検索
        // note: スター数が多い順、1ページごとに50個まで
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(query)+in:name&sort=stars&per_page=\(SearchRepositoryRequest.perPage)&page=\(page)") else {
            // URLが無効な場合
            throw APIError.invalidUrl
        }
        
        // リクエストを行う
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            // ステータスコードが200以外の場合
            throw APIError.unknownError
        }
        
        var result: RepositorySearchResult
        
        do {
            result = try JSONDecoder().decode(RepositorySearchResult.self, from: data)
        } catch {
            // JSONパースできなかった場合
            throw APIError.jsonParseError
        }
        
        if result.items.count == 0 {
            // レスポンスが空の場合
            throw APIError.notFound
        }
        
        return result.items
    }
}

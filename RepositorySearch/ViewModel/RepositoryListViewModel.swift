//
//  RepositoryListViewModel.swift
//  RepositorySearch
//
//  Created by 董 亜飛 on 2022/09/23.
//

import Foundation

@MainActor
final class RepositoryListViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    @Published var error: Error?
    
    private let request = SearchRepositoryRequest()
    
    func onChangeQuery(query: String, isSearching: Bool) {
        if query.isEmpty && !isSearching {
            repositories = []
        }
    }
    
    /// Fetch Github repositories.
    /// - Parameter query string
    /// - Returns: success / fail
    func fetchRepositories(query: String) async -> Bool {
        do {
            repositories = []
            repositories = try await request.fetchRepositories(query: query)
            return true
        } catch(let error) {
            self.error = error
            return false
        }
    }
    
    /// リポジトリを追加検索する
    /// - Parameter query string
    /// - Returns: success / fail
    func fetchAdditionalRepositories(query: String) async -> Bool {
        do {
            let page = Int(repositories.count / SearchRepositoryRequest.perPage) + 1
            repositories += try await request.fetchRepositories(query: query, page: page)
            return true
        } catch(let error) {
            self.error = error
            return false
        }
    }
}

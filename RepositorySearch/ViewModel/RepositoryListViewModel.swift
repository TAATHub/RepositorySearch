//
//  RepositoryListViewModel.swift
//  RepositorySearch
//
//  Created by 董 亜飛 on 2022/09/23.
//

import Foundation

@MainActor
final class RepositoryListViewModel: ObservableObject {
    @Published private (set) var repositories: [Repository] = []
    @Published private (set) var requestError: Error?
    @Published var showAlert = false
    
    private let request = SearchRepositoryRequest()
    
    func onChangeQuery(query: String, isSearching: Bool) {
        if query.isEmpty && !isSearching {
            repositories = []
        }
    }
    
    func onSubmitSearch(query: String) {
        repositories = []
        
        Task {
            do {
                repositories = try await request.fetchRepositories(query: query)
            } catch (let error) {
                requestError = error
                showAlert = true
            }
        }
    }
    
    func onAdditionalLoading(query: String) {        
        Task {
            do {
                let page = Int(repositories.count / SearchRepositoryRequest.perPage) + 1
                repositories += try await request.fetchRepositories(query: query, page: page)
            } catch (let error) {
                requestError = error
                showAlert = true
            }
        }
    }
}

//
//  ContentView.swift
//  RepositorySearch
//
//  Created by 董 亜飛 on 2022/09/23.
//

import SwiftUI

struct RepositoryListView: View {
    @Environment(\.isSearching) var isSearching
    
    @StateObject private var viewModel = RepositoryListViewModel()
    
    @State private var query = ""
    @State private var isShowingAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.repositories) { repository in
                    NavigationLink(destination: RepositoryDetailView(repository: repository)) {
                        RepositoryListItemView(url: URL(string: repository.owner.avatar_url), name: repository.full_name)
                    }
                }
                
                // Additional Loading
                if viewModel.repositories.count >= SearchRepositoryRequest.perPage {
                    Text("loading...")
                        .onAppear {
                            Task {
                                let success = await viewModel.fetchAdditionalRepositories(query: query)
                                isShowingAlert = !success
                            }
                        }
                }
            }
            .listStyle(.plain)
            .navigationBarTitle("Repository Search")
            .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(text: $query,
                    placement: .navigationBarDrawer(displayMode: .always))
        .onSubmit(of: .search) {
            Task {
                let success = await viewModel.fetchRepositories(query: query)
                isShowingAlert = !success
            }
        }
        .onChange(of: query) { newValue in
            viewModel.onChangeQuery(query: query, isSearching: isSearching)
        }.alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Error"),
                  message: Text(viewModel.error?.localizedDescription ?? ""),
                  dismissButton: .default(Text("OK")))
        }
    }
}

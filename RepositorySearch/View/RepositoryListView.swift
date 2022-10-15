//
//  ContentView.swift
//  RepositorySearch
//
//  Created by 董 亜飛 on 2022/09/23.
//

import SwiftUI

struct RepositoryListView<ViewModel: RepositoryListViewModelProtocol>: View {
    @Environment(\.isSearching) var isSearching
    @StateObject var viewModel: ViewModel
    @State private var query = ""
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
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
                            viewModel.onAdditionalLoading(query: query)
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
            viewModel.onSubmitSearch(query: query)
        }
        .onChange(of: query) { newValue in
            viewModel.onChangeQuery(query: query, isSearching: isSearching)
        }.alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"),
                  message: Text(viewModel.requestError?.localizedDescription ?? ""),
                  dismissButton: .default(Text("OK")))
        }
    }
}

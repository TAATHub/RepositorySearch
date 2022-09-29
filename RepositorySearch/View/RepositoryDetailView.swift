//
//  RepositoryDetailView.swift
//  RepositorySearch
//
//  Created by 董 亜飛 on 2022/09/23.
//

import SwiftUI

struct RepositoryDetailView: View {
    let repository: Repository
    
    var body: some View {
        VStack {
            // アイコン
            RepositoryIconView(url: URL(string: repository.owner.avatar_url))
                .padding(16)
            
            // リポジトリ名
            Text(repository.full_name)
                .font(.system(size: 24))
                .padding(16)
            
            // スター数
            HStack(alignment: .bottom) {
                Image(systemName: "star.fill")
                Text("\(repository.stargazers_count)")
            }

            // 説明
            Text(repository.description ?? "")
                .padding(16)
            
            Spacer()
        }
        
    }
}

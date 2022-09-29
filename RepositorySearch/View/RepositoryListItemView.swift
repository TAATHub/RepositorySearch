//
//  RepositoryListItemView.swift
//  RepositorySearch
//
//  Created by 董 亜飛 on 2022/09/24.
//

import SwiftUI

struct RepositoryListItemView: View {
    var url: URL?
    var name: String
    
    var body: some View {
        HStack(spacing: 10) {
            // アイコン画像
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 20, height: 20)
            .clipShape(Circle())
            
            // リポジトリ名
            Text(name)
        }
    }
}

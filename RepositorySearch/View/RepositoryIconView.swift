//
//  RepositoryIconView.swift
//  RepositorySearch
//
//  Created by 董 亜飛 on 2022/09/24.
//

import SwiftUI

struct RepositoryIconView: View {
    let url: URL?

    var body: some View {
        AsyncImage(url: url) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .background(Color.white)
        .frame(width: 200, height: 200)
        .clipShape(Circle())
        .overlay(
            RoundedRectangle(cornerRadius: 100)
                .stroke(Color.white, lineWidth: 4)
        )
        .shadow(radius: 8)
    }
}

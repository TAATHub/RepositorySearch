//
//  Repository.swift
//  RepositorySearch
//
//  Created by 董 亜飛 on 2022/09/23.
//

import Foundation

struct RepositorySearchResult: Codable {
    var total_count: Int
    var items: [Repository]
}

struct Repository: Codable, Identifiable {
    var id: Int
    var name: String
    var full_name: String
    var owner: Owner
    var description: String?
    var stargazers_count: Int
}

struct Owner: Codable {
    var id: Int
    var avatar_url: String
}

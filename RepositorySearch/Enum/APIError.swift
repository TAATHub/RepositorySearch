//
//  APIError.swift
//  RepositorySearch
//
//  Created by 董 亜飛 on 2022/09/23.
//

import Foundation

enum APIError: Error, LocalizedError {
    case customError(message: String)
    case invalidUrl
    case notFound
    case jsonParseError
    case unknownError
        
    var errorDescription: String? {
        switch self {
        case .customError(let message):
            return message
        case .invalidUrl:
            return "Invalid URL."
        case .notFound:
            return "Not found."
        case .jsonParseError:
            return "Failed to parse JSON."
        default:
            return "Request failed."
        }
    }
}

//
//  DataRequestExtension.swift
//  RepositorySearch
//
//  Created by 董 亜飛 on 2022/10/15.
//

import Foundation
import Alamofire

extension DataRequest {
    
    /// Async response with generic type
    /// - Returns: Generic Type
    func response<T>() async throws -> T where T : Decodable {
        try await withCheckedThrowingContinuation { continuation in
            self.response { response in
                switch response.result {
                case .success(let element):
                    do {
                        continuation.resume(returning: try JSONDecoder().decode(T.self, from: element!))
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

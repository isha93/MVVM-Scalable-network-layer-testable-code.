//
//  MockNetworker.swift
//  AtomicDesignTests
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import Foundation
@testable import AtomicDesign

class MockNetworker: NetworkerProtocol {
    enum Mode { case success, failure(Error) }
    var mode: Mode = .success
    var mockResponse: Any?
    
    func requestAsync<T>(type: T.Type, endPoint: Endpoint) async throws -> T where T : Decodable {
        switch mode {
        case .success:
            guard let response = mockResponse as? T else {
                throw APIRequestError.decodingError(message: "Mock response type mismatch")
            }
            return response
        case .failure(let error):
            throw error
        }
    }
}

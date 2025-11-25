//
//  APIRequestError.swift
//  iosApp
//
//  Created by Isa Nur Fajar on 2025/09/12.
//  Copyright © 2025 Terra Charge. All rights reserved.
//

import Foundation

public enum APIRequestError: Error, LocalizedError {
    case badRequest(message: String)
    case apiError(code: Int, message: String)
    case internetError(message: String)
    case decodingError(message: String)
    case encodingError(message: String)
    case invalidResponse(message: String)
    case unAuthorized
    
    var localizedDescription: String {
        switch self {
        case .badRequest(let message),
                .apiError(_, let message),
                .decodingError(let message),
                .encodingError(let message),
                .invalidResponse(let message):
            return message
        case .internetError:
            return "No internet connection"
        case .unAuthorized:
            return "Authentication Failed" 
        }
    }
    
    var titleDescription: String {
        return "Error"
    }
    
    var isUnAuthorized: Bool {
        switch self {
        case .apiError,
                .encodingError,
                .badRequest,
                .internetError,
                .decodingError,
                .invalidResponse:
            return false
        case .unAuthorized:
            return true
        }
    }
}

enum ErrorState {
    case idle
    case middlewareError
    case internetError
    case unAuthorized
}

struct NetworkHandle: Codable {
    let code: Int?
    let body: NetworkHandleBody?
}

struct NetworkHandleBody: Codable {
    let message: String?
}

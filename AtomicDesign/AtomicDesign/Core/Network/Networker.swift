//
//  Networker.swift
//  iosApp
//
//  Created by Isa Nur Fajar on 2025/09/12.
//  Copyright © 2025 Terra Charge. All rights reserved.
//

import Foundation

protocol NetworkerProtocol: AnyObject {
    func requestAsync<T>(type: T.Type,
                         endPoint: Endpoint
    ) async throws -> T where T: Decodable
}

final class Networker: NetworkerProtocol {
    private let tokenRefresher = TokenRefresher()
    
    func requestAsync<T>(type: T.Type, endPoint: Endpoint) async throws -> T where T: Decodable {
        let data: Data
        let response: URLResponse
        let commandType = "API-ERROR: \(endPoint.path)"

        var urlRequest: URLRequest
        do {
            urlRequest = try URLRequest(endpoint: endPoint)
        } catch {
            print("❌ FAILED TO CREATE URLRequest: \(error)")
            throw APIRequestError.badRequest(message: "Failed to create request from endpoint.")
        }
        
        NetworkLogger.log(request: urlRequest)
        
        do {
            (data, response) = try await URLSession.shared.data(for: urlRequest)
        } catch {
            print("❌ NETWORK ERROR: \(error.localizedDescription)")
            throw APIRequestError.internetError(message: "Connection Error: \(error.localizedDescription)")
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            let errorMessage = "Invalid response from server."
            throw APIRequestError.invalidResponse(message: errorMessage)
        }
        
        NetworkLogger.log(response: httpResponse, data: data)

        guard 200..<300 ~= httpResponse.statusCode else {
            let res = try? JSONDecoder().decode(NetworkHandle.self, from: data)
            
            switch httpResponse.statusCode {
            case 400:
                let errorMessage = res?.body?.message ?? "Bad Request"
                throw APIRequestError.badRequest(message: errorMessage)
            case 401, 403:
                return try await refreshTokenAndRetry(endPoint, type: type)
            default:
                let errorMessage = res?.body?.message ?? "An error occurred."
                throw APIRequestError.apiError(code: res?.code ?? httpResponse.statusCode, message: errorMessage)
            }
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedObject = try decoder.decode(type, from: data)
            return decodedObject
        } catch let decodingError as DecodingError {
            #if DEBUG
            print("❌ DECODING ERROR: \(decodingError)")
            if let bodyString = String(data: data, encoding: .utf8) {
                print("--- FAILED TO DECODE THIS ---")
                print(bodyString)
                print("-----------------------------")
            }
            #endif
            throw APIRequestError.decodingError(message: "Failed to parse server response.")
        }
    }
}

extension Networker {
    /// Handles the token refresh process and retries the original request.
    /// This function is called when a 401 or 403 status code is received.
    /// - Parameters:
    ///   - endPoint: The original endpoint that failed.
    ///   - type: The decodable type for the request.
    /// - Returns: The decoded object after a successful retry.
    /// - Throws: `NetworkError.unAuthorized` if the refresh fails or if it's a refresh loop.
    private func refreshTokenAndRetry<T: Decodable>(
        _ endPoint: Endpoint,
        type: T.Type
    ) async throws -> T {
        NetworkLogger.log(message: "Token expired. Attempting to refresh...", icon: "🔧")
        let commandType = "API-ERROR: \(endPoint.path)"

        do {
            try await tokenRefresher.handleRefresh()
            NetworkLogger.log(message: "Token refreshed successfully. Retrying request...", icon: "✅")
            return try await requestAsync(type: type, endPoint: endPoint)
            
        } catch {
            NetworkLogger.log(message: "Failed to refresh token. Logging out.", icon: "❌")
            throw APIRequestError.unAuthorized
        }
    }
}

//
//  TokenRefresherService.swift
//  iosApp
//
//  Created by Isa Nur Fajar on 2025/10/14.
//  Copyright © 2025 Terra Charge. All rights reserved.
//
import Foundation
// MARK: - Token Refresher Actor
/// If multiple requests fail with a 401/403, this actor ensures only one
/// refresh attempt is made, while other requests wait for the result.
actor TokenRefresher {
    private var refreshTask: Task<Void, Error>?
    private var appState: AppState = AppState.shared
    func handleRefresh() async throws {
        if let existingTask = refreshTask {
            NetworkLogger.log(message: "TokenRefresher: Joining existing refresh task...", icon: "⏳")
            return try await existingTask.value
        }

        let newTask = Task { () throws -> Void in
            defer { self.refreshTask = nil }

            NetworkLogger.log(message: "TokenRefresher: Starting new token refresh task...", icon: "🔧")
            
            do {
                guard let refreshToken = KeychainManager.shared.getValue(forKey: .refreshToken), !refreshToken.isEmpty else {
                    NetworkLogger.log(message: "TokenRefresher: No refresh token found in keychain.", icon: "❌")
                    throw APIRequestError.unAuthorized
                }
                
                let refreshRequest = RefreshTokenParameter(refreshToken: refreshToken)
                let endpoint = RefreshTokenAPI.refreshToken(refreshRequest)
                let urlRequest = try URLRequest(endpoint: endpoint)
                
                NetworkLogger.log(request: urlRequest)
                
                let (data, response) = try await URLSession.shared.data(for: urlRequest)
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIRequestError.apiError(code: 500, message: "Invalid server response type.")
                }
                
                NetworkLogger.log(response: httpResponse, data: data)
                
                guard httpResponse.statusCode == 200 else {
                    KeychainManager.shared.deleteAll() // Assume invalid session if refresh fails
                    throw APIRequestError.unAuthorized
                }

                let decoder = JSONDecoder()
                let tokenResponse = try decoder.decode(RefreshTokenDTO.self, from: data)

                guard let accessToken = tokenResponse.data?.accessToken else {
                    throw APIRequestError.decodingError(message: "Access token was missing from refresh response.")
                }
                
                KeychainManager.shared.save(accessToken, forKey: .accessToken)
                NetworkLogger.log(message: "TokenRefresher: Tokens refreshed and saved successfully.", icon: "✅")

            } catch {
                appState.forceLogout()
                NetworkLogger.log(message: "TokenRefresher: Task failed. Error: \(error.localizedDescription)", icon: "❌")
                throw error
            }
        }
        
        self.refreshTask = newTask
        
        return try await newTask.value
    }
}

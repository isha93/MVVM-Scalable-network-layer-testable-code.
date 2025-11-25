//
//  NetworkFactory.swift
//  iosApp
//
//  Created by Isa Nur Fajar on 2025/09/12.
//  Copyright © 2025 Terra Charge. All rights reserved.
//

import Foundation

extension URLRequest {
    init(endpoint: Endpoint) throws {
        var components = URLComponents()
        components.scheme = "https"
        components.host = endpoint.baseURL
        components.path = Constants.apiPathPrefix + endpoint.path
        
        guard let url = components.url else { throw APIRequestError.badRequest(message: "Invalid URL") }
        
        self.init(url: url, timeoutInterval: endpoint.timeoutInterval)
        
        self.httpMethod = endpoint.method.rawValue
        
        HTTPHeaders.defaultHeaders().forEach { key, value in
            self.setValue(value, forHTTPHeaderField: key)
        }
        
        endpoint.headers?.forEach { key, value in
            self.setValue(value, forHTTPHeaderField: key)
        }
    
        if endpoint.authorizationType == .authorized {
            if let token = KeychainManager.shared.getValue(forKey: .accessToken) {
                self.setValue(token, forHTTPHeaderField: "Authorization")
            } else {
                //TODO: handle refresh token or logout user
                print("⚠️ Attempted to make an authorized request without a token.")
            }
        }

        
        switch endpoint.task {
        case .requestPlain:
            self.setValue("0", forHTTPHeaderField: "Content-Length")
            
        case .requestURLParameters(let parameters):
            var queryItems = [URLQueryItem]()
            parameters.forEach { queryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)")) }
            components.queryItems = queryItems
            self.url = components.url
            
        case .requestJSONEncodable(let body):
            let encoder = JSONEncoder()
            do {
                self.httpBody = try encoder.encode(body)
            } catch {
                throw APIRequestError.encodingError(message: error.localizedDescription)
            }
        }
    }
}

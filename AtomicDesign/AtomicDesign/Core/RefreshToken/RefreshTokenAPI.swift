//
//  RefreshTokenAPI.swift
//  iosApp
//
//  Created by Isa Nur Fajar on 2025/10/14.
//  Copyright © 2025 Terra Charge. All rights reserved.
//

import Foundation

enum RefreshTokenAPI {
    case refreshToken(RefreshTokenParameter)
}

extension RefreshTokenAPI: Endpoint {
    var method: HTTPMethod {
        switch self {
        case .refreshToken:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .refreshToken(let data):
            return .requestJSONEncodable(data)
        }
    }
    
    var path: String {
        switch self {
        case .refreshToken:
            return "/user/login/sms/verify/refresh"
        }
    }
    
    var authorizationType: AuthorizationType {
        return .anonymous
    }
}


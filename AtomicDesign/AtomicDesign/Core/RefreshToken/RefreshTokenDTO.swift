//
//  RefreshTokenDTO.swift
//  iosApp
//
//  Created by Isa Nur Fajar on 2025/10/14.
//  Copyright © 2025 Terra Charge. All rights reserved.
//
import Foundation

// MARK: - RefreshToken
struct RefreshTokenDTO: Codable {
    let statusCode: Int?
    let data: RefreshTokenDataClass?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case data
    }
}

// MARK: - DataClass
struct RefreshTokenDataClass: Codable {
    let accessToken: String?
    let expires: Int?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expires
    }
}

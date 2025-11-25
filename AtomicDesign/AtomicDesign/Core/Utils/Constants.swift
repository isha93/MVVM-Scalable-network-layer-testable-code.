//
//  Constants.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/11/25.
//

import Foundation

class Constants {
    static var baseURL: String {
        #if DEBUG
        return "pokeapi.co"
        #else
        return "pokeapi.co"
        #endif
    }
    
    static var apiPathPrefix: String {
        #if DEBUG
        return "/api/v2/"
        #else
        return ""
        #endif
    }
}

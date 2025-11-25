//
//  PokemonAPI.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/11/25.
//


enum HomeAPI {
    case getPokemonList(limit: Int, offset: Int)
    case getPokemonDetail(name: String)
}

extension HomeAPI: Endpoint {    
    var path: String {
        switch self {
        case .getPokemonList:
            return "pokemon"
        case .getPokemonDetail(let name):
            return "pokemon/\(name)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .getPokemonList(let limit, let offset):
            return .requestURLParameters([
                "limit": limit,
                "offset": offset
            ])
            
        case .getPokemonDetail:
            return .requestPlain
        }
    }
    
    var authorizationType: AuthorizationType {
        return .anonymous
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var timeoutInterval: Double {
        return 30.0
    }
}

//
//  PokeDetailService.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import Foundation

protocol PokeDetailServiceProtocol {
    func fetchPokemonDetail(idOrName: String) async throws -> PokemonDetailResponse
}

final class PokeDetailService: PokeDetailServiceProtocol {
    private let networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func fetchPokemonDetail(idOrName: String) async throws -> PokemonDetailResponse {
        let endpoint = PokeDetailAPI.getPokemonDetail(name: idOrName)
        return try await networker.requestAsync(type: PokemonDetailResponse.self, endPoint: endpoint)
    }
}

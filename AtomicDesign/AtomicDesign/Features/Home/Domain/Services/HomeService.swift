//
//  HomeServiceProtocol.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/11/25.
//


protocol HomeServiceProtocol {
    func fetchPokemons(limit: Int, offset: Int) async throws -> PokemonListResponse
}

final class HomeService: HomeServiceProtocol {
    private let networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func fetchPokemons(limit: Int, offset: Int) async throws -> PokemonListResponse {
        let endpoint = HomeAPI.getPokemonList(limit: limit, offset: offset)
        return try await networker.requestAsync(type: PokemonListResponse.self, endPoint: endpoint)
    }
}

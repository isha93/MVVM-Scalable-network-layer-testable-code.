//
//  MockPokeDetailService.swift
//  AtomicDesignTests
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import Foundation
@testable import AtomicDesign

class MockPokeDetailService: PokeDetailServiceProtocol {
    enum Mode { case success, failure(Error) }
    var mode: Mode = .success
    var mockResponse: PokemonDetailResponse?
    
    func fetchPokemonDetail(idOrName: String) async throws -> PokemonDetailResponse {
        switch mode {
        case .success:
            guard let response = mockResponse else {
                throw APIRequestError.badRequest(message: "Mock response not set")
            }
            return response
        case .failure(let error):
            throw error
        }
    }
}

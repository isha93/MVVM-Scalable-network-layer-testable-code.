//
//  PokeListServiceTests.swift
//  AtomicDesignTests
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import XCTest
@testable import AtomicDesign

final class PokeListServiceTests: XCTestCase {
    
    // Test: Fetch Pokemons (Success)
    func test_fetchPokemons_success_shouldReturnList() async throws {
        // Given
        let mock = MockNetworker()
        mock.mode = .success
        mock.mockResponse = PokemonListResponse.mock(name: "bulbasaur")
        let service = PokeListService(networker: mock)
        
        // When
        let response = try await service.fetchPokemons(limit: 20, offset: 0)
        
        // Then
        XCTAssertEqual(response.results.first?.name, "bulbasaur")
    }
    
    // Test: Fetch Pokemons (Failure)
    func test_fetchPokemons_failure_shouldThrowError() async {
        // Given
        let mock = MockNetworker()
        mock.mode = .failure(APIRequestError.badRequest(message: "Bad Request"))
        let service = PokeListService(networker: mock)
        
        // When/Then
        do {
            _ = try await service.fetchPokemons(limit: 20, offset: 0)
            XCTFail("Expected error not thrown")
        } catch {
            XCTAssertTrue(error is APIRequestError)
        }
    }
}

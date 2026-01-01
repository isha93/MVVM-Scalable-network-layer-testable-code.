//
//  PokeDetailServiceTests.swift
//  AtomicDesignTests
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import XCTest
@testable import AtomicDesign

final class PokeDetailServiceTests: XCTestCase {
    
    // Test: Fetch Detail (Success)
    func test_fetchPokemonDetail_success_shouldReturnDetail() async throws {
        // Given
        let mock = MockNetworker()
        mock.mode = .success
        // Construct a Mock Response
        let detail = PokemonDetailResponse(
            id: 1,
            name: "bulbasaur",
            height: 7,
            weight: 69,
            sprites: PokemonSprites(frontDefault: "url", other: nil),
            stats: [],
            types: [],
            abilities: []
        )
        mock.mockResponse = detail
        let service = PokeDetailService(networker: mock)
        
        // When
        let response = try await service.fetchPokemonDetail(idOrName: "bulbasaur")
        
        // Then
        XCTAssertEqual(response.name, "bulbasaur")
        XCTAssertEqual(response.id, 1)
    }
    
    // Test: Fetch Detail (Not Found)
    func test_fetchPokemonDetail_notFound_shouldThrowError() async {
        // Given
        let mock = MockNetworker()
        // Simulate 404
        mock.mode = .failure(APIRequestError.apiError(code: 404, message: "Not Found"))
        let service = PokeDetailService(networker: mock)
        
        // When/Then
        do {
            _ = try await service.fetchPokemonDetail(idOrName: "missingno")
            XCTFail("Expected error not thrown")
        } catch let error as APIRequestError {
            if case .apiError(let code, _) = error {
                XCTAssertEqual(code, 404)
            } else {
                XCTFail("Wrong error type")
            }
        } catch {
            XCTFail("Generic error caught")
        }
    }
    
    // Test: Fetch Detail (Bad Request)
    func test_fetchPokemonDetail_badRequest_shouldThrowError() async {
        // Given
        let mock = MockNetworker()
        mock.mode = .failure(APIRequestError.badRequest(message: "Bad Request"))
        let service = PokeDetailService(networker: mock)
        
        // When/Then
        do {
            _ = try await service.fetchPokemonDetail(idOrName: "")
            XCTFail("Expected error not thrown")
        } catch {
            XCTAssertTrue(error is APIRequestError)
        }
    }
}

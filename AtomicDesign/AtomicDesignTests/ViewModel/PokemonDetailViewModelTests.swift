//
//  PokemonDetailViewModelTests.swift
//  AtomicDesignTests
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import XCTest
@testable import AtomicDesign

final class PokemonDetailViewModelTests: XCTestCase {
    
    // MARK: - Tests
    
    // Test: Load Detail (Success)
    func test_loadDetail_success_shouldAssignPokemon() async {
        // Given
        let mock = MockPokeDetailService()
        mock.mode = .success
        // We need a mock PokemonDetailResponse. 
        // Assuming we need to add a mock() helper to PokemonDetailResponse or construct one manually.
        // Since we didn't add .mock() to PokemonDetailResponse, let's construct it.
        mock.mockResponse = PokemonDetailResponse(
            id: 25,
            name: "pikachu",
            height: 4,
            weight: 60,
            sprites: PokemonSprites(frontDefault: "url", other: nil),
            stats: [],
            types: [],
            abilities: []
        )
        let vm = PokemonDetailViewModel(pokeDetailService: mock)

        // When
        await vm.loadDetail(name: "pikachu")

        // Then
        XCTAssertNotNil(vm.pokemon)
        XCTAssertEqual(vm.pokemon?.name, "pikachu")
        XCTAssertFalse(vm.isLoading)
    }

    // Test: Load Detail (Not Found)
    func test_loadDetail_notFound_shouldNotCrash() async {
        // Given
        let mock = MockPokeDetailService()
        mock.mode = .failure(APIRequestError.apiError(code: 404, message: "Not Found"))
        let vm = PokemonDetailViewModel(pokeDetailService: mock)

        // When
        await vm.loadDetail(name: "agumon")

        // Then
        XCTAssertNil(vm.pokemon)
        XCTAssertFalse(vm.isLoading)
    }
    
    // Test: Load Detail (General Failure)
    func test_loadDetail_failure_shouldHandleGracefully() async {
        // Given
        let mock = MockPokeDetailService()
        mock.mode = .failure(APIRequestError.badRequest(message: "Bad Request"))
        let vm = PokemonDetailViewModel(pokeDetailService: mock)
        
        // When
        await vm.loadDetail(name: "")
        
        // Then
        XCTAssertNil(vm.pokemon)
        XCTAssertFalse(vm.isLoading)
    }
}

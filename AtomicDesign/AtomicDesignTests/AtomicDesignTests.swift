//
//  AtomicDesignTests.swift
//  AtomicDesignTests
//
//  Created by Isa Nur Fajar on 2025/10/07.
//

import Testing
import XCTest
@testable import AtomicDesign

final class MockNetworker: NetworkerProtocol {
    var result: Any?
    var error: Error?
    var lastEndpointCalled: Endpoint?

    func requestAsync<T>(type: T.Type, endPoint: Endpoint) async throws -> T where T : Decodable {
        lastEndpointCalled = endPoint
        
        if let error = error {
            throw error
        }
        
        if let result = result as? T {
            return result
        }
        
        throw APIRequestError.badRequest(message: "Mock result not set")
    }
}

final class MockHomeService: HomeServiceProtocol {
    var pokemonResponse: PokemonListResponse?
    var error: Error?
    
    func fetchPokemons(limit: Int, offset: Int) async throws -> PokemonListResponse {
        if let error = error {
            throw error
        }
        
        if let response = pokemonResponse {
            return response
        }
        
        return PokemonListResponse(count: 0, next: nil, previous: nil, results: [])
    }
}

final class HomeServiceTests: XCTestCase {
    
    var service: HomeService!
    var mockNetworker: MockNetworker!
    
    override func setUp() {
        super.setUp()
        mockNetworker = MockNetworker()
        service = HomeService(networker: mockNetworker)
    }
    
    override func tearDown() {
        service = nil
        mockNetworker = nil
        super.tearDown()
    }
    
    func testFetchPokemons_Success() async {
        // GIVEN: Networker disiapkan untuk sukses
        let expectedPokemon = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
        let mockResponse = PokemonListResponse(count: 1, next: nil, previous: nil, results: [expectedPokemon])
        mockNetworker.result = mockResponse
        
        // WHEN: Service dipanggil
        do {
            let response = try await service.fetchPokemons(limit: 20, offset: 0)
            
            // THEN: Hasilnya harus sesuai dengan mock
            XCTAssertEqual(response.results.count, 1)
            XCTAssertEqual(response.results.first?.name, "bulbasaur")
            
            // Verifikasi apakah endpoint yang dipanggil benar
            XCTAssertEqual(mockNetworker.lastEndpointCalled?.path, "pokemon")
            XCTAssertEqual(mockNetworker.lastEndpointCalled?.method, .get)
        } catch {
            XCTFail("Service should succeed but failed with error: \(error)")
        }
    }
    
    func testFetchPokemons_Failure() async {
        // GIVEN: Networker disiapkan untuk gagal (No Internet)
        mockNetworker.error = APIRequestError.internetError(message: "No connection")
        
        // WHEN: Service dipanggil
        do {
            _ = try await service.fetchPokemons(limit: 20, offset: 0)
            XCTFail("Service should throw error")
        } catch let error as APIRequestError {
            // THEN: Error yang dilempar harus sesuai
            XCTAssertEqual(error.localizedDescription, "No internet connection")
        } catch {
            XCTFail("Unexpected error type")
        }
    }
}

@MainActor
final class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mockService: MockHomeService!
    
    override func setUp() {
        super.setUp()
        mockService = MockHomeService()
        viewModel = HomeViewModel(service: mockService)
    }
    
    func testLoadPokemons_Success() async {
        // GIVEN: Service sukses mengembalikan data
        let pikachu = Pokemon(name: "pikachu", url: "url")
        mockService.pokemonResponse = PokemonListResponse(count: 1, next: nil, previous: nil, results: [pikachu])
        
        // State awal
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.pokemonList.isEmpty)
        
        // WHEN: Fungsi dipanggil
        await viewModel.loadPokemons()
        
        // THEN: State harus terupdate
        XCTAssertFalse(viewModel.isLoading, "Loading harus false setelah selesai")
        XCTAssertFalse(viewModel.showError, "Tidak boleh ada error")
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.pokemonList.count, 1)
        XCTAssertEqual(viewModel.pokemonList.first?.name, "pikachu")
    }
    
    func testLoadPokemons_Failure() async {
        // GIVEN: Service gagal
        let errorMsg = "Server Down"
        mockService.error = APIRequestError.apiError(code: 500, message: errorMsg)
        
        // WHEN: Fungsi dipanggil
        await viewModel.loadPokemons()
        
        // THEN: UI harus menampilkan error
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.pokemonList.isEmpty, "List harus kosong jika error")
    }
    
    func testLoadPokemons_LoadingState() async {
        // GIVEN
        mockService.pokemonResponse = PokemonListResponse(count: 0, next: nil, previous: nil, results: [])
        
        // WHEN & THEN (Manual inspection of logic flow)
        
        await viewModel.loadPokemons()
        XCTAssertFalse(viewModel.isLoading)
    }
}

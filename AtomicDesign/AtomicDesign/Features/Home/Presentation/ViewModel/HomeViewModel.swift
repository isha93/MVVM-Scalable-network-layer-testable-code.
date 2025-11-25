//
//  HomeViewModel.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/11/25.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var pokemonList: [Pokemon] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var showError: Bool = false
    
    private let service: HomeServiceProtocol
    
    init(service: HomeServiceProtocol = HomeService()) {
        self.service = service
    }
    
    func loadPokemons() async {
        self.isLoading = true
        self.errorMessage = nil
        defer { isLoading = false }
        do {
            let response = try await service.fetchPokemons(limit: 100, offset: 0)
            self.pokemonList = response.results
            self.isLoading = false
        } catch {
            self.showError = true
            self.errorMessage = error.localizedDescription
        }
    }
}

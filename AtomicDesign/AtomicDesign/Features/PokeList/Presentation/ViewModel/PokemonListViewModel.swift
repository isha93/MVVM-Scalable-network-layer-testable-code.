//
//  PokemonListViewModel.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/12/01.
//


import SwiftUI

@Observable
class PokemonListViewModel {
    var pokemons: [Pokemon] = []
    var isLoading: Bool = false
    var offset: Int = 0
    var hasMore: Bool = true
    private let limit: Int = 20
    
    private let pokeListService: PokeListServiceProtocol
    
    init(pokeListService: PokeListServiceProtocol = PokeListService()) {
        self.pokeListService = pokeListService
    }
    
    func loadData() async {
        guard !isLoading && pokemons.isEmpty else { return }
        self.isLoading = true
        self.offset = 0
        self.hasMore = true
        
        do {
            let response = try await pokeListService.fetchPokemons(limit: limit, offset: offset)
            self.pokemons = response.results
            self.offset += limit
            self.hasMore = response.next != nil
        } catch {
            print("Error loading data: \(error)")
        }
        self.isLoading = false
    }
    
    func loadMore() async {
        guard !isLoading && hasMore else { return }
        self.isLoading = true
        
        do {
            let response = try await pokeListService.fetchPokemons(limit: limit, offset: offset)
            self.pokemons.append(contentsOf: response.results)
            self.offset += limit
            self.hasMore = response.next != nil
        } catch {
            print("Error loading more data: \(error)")
        }
        self.isLoading = false
    }
}

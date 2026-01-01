//
//  PokemonListView.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/12/01.
//


import SwiftUI

struct PokemonListView: View {
    @Environment(AppRouter.self) var router
    @State var viewModel: PokemonListViewModel
    
    var body: some View {
        List {
            Section {
                if !viewModel.pokemons.isEmpty {
                    FeaturedCarouselOrganism(
                        pokemons: Array(viewModel.pokemons.prefix(5))
                    ) { pokemon in
                        router.push(.detail(name: pokemon.name))
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .padding(.vertical, 16)
                    .background(Color.gray.opacity(0.05))
                }
            }
            
            if viewModel.isLoading && viewModel.pokemons.isEmpty {
                ProgressView("Catching Pokemons...")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowSeparator(.hidden)
            } else {
                ForEach(viewModel.pokemons) { pokemon in
                    Button {
                        router.push(.detail(name: pokemon.name))
                    } label: {
                        PokemonRowMolecule(pokemon: pokemon)
                    }
                    .buttonStyle(.scalable)
                    .listRowSeparator(.hidden) // Cleaner look
                    .onAppear {
                        if pokemon.id == viewModel.pokemons.last?.id {
                            Task {
                                await viewModel.loadMore()
                            }
                        }
                    }
                }
                
                if viewModel.isLoading && !viewModel.pokemons.isEmpty {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .listRowSeparator(.hidden)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Pokedex")
        .task {
            await viewModel.loadData()
        }
    }
}

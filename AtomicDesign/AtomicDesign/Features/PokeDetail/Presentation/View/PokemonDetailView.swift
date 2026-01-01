//
//  PokemonDetailView.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/12/01.
//


import SwiftUI

struct PokemonDetailView: View {
    @State var viewModel: PokemonDetailViewModel
    let pokemonName: String
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.top, 100)
                } else if let pokemon = viewModel.pokemon {
                    PokemonDetailHeaderOrganism(
                        name: pokemon.name,
                        imageUrl: pokemon.imageUrl,
                        types: pokemon.types.map { $0.type.name },
                        height: pokemon.height,
                        weight: pokemon.weight
                    )
                    
                    PokemonStatsChartOrganism(stats: pokemon.stats)
                        .padding(.horizontal)
                        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                    
                    // Abilities Section
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeaderAtom(title: "Abilities")
                        
                        FlowLayout(spacing: 8) { 
                            ForEach(pokemon.abilities) { ability in
                                Text(ability.ability.name.capitalized)
                                    .font(.system(.subheadline, design: .rounded, weight: .semibold))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundColor(.blue)
                                    .clipShape(Capsule())
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.bottom, 40)
        }
        .padding()
        .navigationTitle(pokemonName)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadDetail(name: pokemonName)
        }
    }
}

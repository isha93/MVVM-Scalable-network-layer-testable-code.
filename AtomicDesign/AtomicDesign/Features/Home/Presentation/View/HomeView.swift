//
//  HomeView.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/10/07.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                List(viewModel.pokemonList) { pokemon in
                    HStack(spacing: 16) {
                        AsyncImage(url: pokemon.imageUrl) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable()
                                     .aspectRatio(contentMode: .fit)
                            case .failure:
                                Image(systemName: "pawprint.fill")
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(width: 50, height: 50)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        
                        Text(pokemon.name.capitalized)
                            .font(.headline)
                        
                        Spacer()
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(.plain)
                
                if viewModel.isLoading {
                    ProgressView("Catching Pokemons...")
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Pokedex")
            .task {
                if viewModel.pokemonList.isEmpty {
                    await viewModel.loadPokemons()
                }
            }
            .alert(isPresented: $viewModel.showError) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
            }
        }
    }
}

// Preview Provider
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

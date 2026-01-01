//
//  PokemonRowMolecule.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

/// A Molecule representing a row in a list of Pokemons.
/// Composed of Image and Name Atoms.
struct PokemonRowMolecule: View {
    let pokemon: Pokemon
    
    var body: some View {
        HStack(spacing: 16) {
            PokemonImageAtom(url: pokemon.imageUrl, width: 60, height: 60)
                .background(
                    Circle()
                        .fill(Color.gray.opacity(0.1))
                )
                .clipShape(Circle())
            
            PokemonNameAtom(name: pokemon.name, style: .rowTitle)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray.opacity(0.5))
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle()) // Ensures tap area is solid
    }
}

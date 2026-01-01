//
//  PokemonCardMolecule.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

/// A Molecule representing a singular Pokemon card.
/// Composed of Image, Name, and Background Atoms.
struct PokemonCardMolecule: View {
    let pokemon: Pokemon
    
    var body: some View {
        VStack(spacing: 8) {
            PokemonImageAtom(url: pokemon.imageUrl)
                .frame(width: 80, height: 80)
                .padding(12)
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.8))
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                )
            
            PokemonNameAtom(name: pokemon.name, style: .cardTitle)
                .foregroundColor(.white)
        }
        .frame(width: 140, height: 160)
        .background(CardBackgroundAtom())
    }
}

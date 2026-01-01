//
//  FeaturedCarouselOrganism.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

/// An Organism displaying a horizontal carousel of featured Pokemons.
/// Composed of Section Header Atom and Pokemon Card Molecules.
struct FeaturedCarouselOrganism: View {
    let pokemons: [Pokemon]
    var onSelect: (Pokemon) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeaderAtom(title: "Featured Pokemons")
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(pokemons) { pokemon in
                        Button {
                            onSelect(pokemon)
                        } label: {
                            PokemonCardMolecule(pokemon: pokemon)
                        }
                        .buttonStyle(.scalable)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
        }
    }
}

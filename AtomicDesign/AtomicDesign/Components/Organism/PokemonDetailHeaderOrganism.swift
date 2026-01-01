//
//  PokemonDetailHeaderOrganism.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

struct PokemonDetailHeaderOrganism: View {
    let name: String
    let imageUrl: URL?
    let types: [String]
    let height: Int
    let weight: Int
    
    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 280, height: 280)
                
                PokemonImageAtom(url: imageUrl, width: 220, height: 220)
            }
            
            VStack(spacing: 8) {
                PokemonNameAtom(name: name, style: .detailTitle)
                
                TypeListMolecule(types: types)
            }
            
            TraitGridMolecule(height: height, weight: weight)
                .padding(.horizontal)
        }
    }
}

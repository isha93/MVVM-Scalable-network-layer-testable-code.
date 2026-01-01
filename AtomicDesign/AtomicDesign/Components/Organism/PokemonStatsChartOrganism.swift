//
//  PokemonStatsChartOrganism.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

struct PokemonStatsChartOrganism: View {
    let stats: [PokemonStat]
    
    var body: some View {
        VStack(spacing: 16) {
            SectionHeaderAtom(title: "Base Stats")
            
            VStack(spacing: 12) {
                ForEach(stats) { stat in
                    StatRowMolecule(
                        statName: stat.stat.name,
                        value: stat.baseStat,
                        color: colorForStat(stat.stat.name)
                    )
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(Color.white)
        .cornerRadius(24)
    }
    
    private func colorForStat(_ name: String) -> Color {
        switch name {
        case "hp": return .red
        case "attack": return .orange
        case "defense": return .yellow
        case "special-attack": return .blue
        case "special-defense": return .green
        case "speed": return .pink
        default: return .gray
        }
    }
}

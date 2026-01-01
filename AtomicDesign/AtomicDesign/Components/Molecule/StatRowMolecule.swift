//
//  StatRowMolecule.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

struct StatRowMolecule: View {
    let statName: String
    let value: Int
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Text(statLabel)
                .font(.system(.callout, design: .rounded, weight: .bold))
                .foregroundColor(.secondary)
                .frame(width: 40, alignment: .leading)
            
            Text("\(value)")
                .font(.system(.subheadline, design: .rounded, weight: .regular))
                .frame(width: 30, alignment: .trailing)
            
            StatBarAtom(value: value, color: color)
        }
    }
    
    private var statLabel: String {
        switch statName {
        case "hp": return "HP"
        case "attack": return "ATK"
        case "defense": return "DEF"
        case "special-attack": return "SATK"
        case "special-defense": return "SDEF"
        case "speed": return "SPD"
        default: return statName.prefix(3).uppercased()
        }
    }
}

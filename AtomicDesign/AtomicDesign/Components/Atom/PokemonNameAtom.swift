//
//  PokemonNameAtom.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

enum PokemonNameStyle {
    case cardTitle
    case rowTitle
    case detailTitle
}

/// An Atom for displaying Pokemon names with consistent typography.
struct PokemonNameAtom: View {
    let name: String
    let style: PokemonNameStyle
    
    var body: some View {
        Text(name.capitalized)
            .font(fontForStyle(style))
            .foregroundColor(colorForStyle(style))
    }
    
    private func fontForStyle(_ style: PokemonNameStyle) -> Font {
        switch style {
        case .cardTitle:
            return .system(.subheadline, design: .rounded, weight: .bold)
        case .rowTitle:
            return .system(.headline, design: .rounded, weight: .semibold)
        case .detailTitle:
            return .system(.largeTitle, design: .rounded, weight: .heavy)
        }
    }
    
    private func colorForStyle(_ style: PokemonNameStyle) -> Color {
        return .primary
    }
}

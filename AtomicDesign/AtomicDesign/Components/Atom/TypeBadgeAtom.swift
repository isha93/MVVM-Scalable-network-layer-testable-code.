//
//  TypeBadgeAtom.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

struct TypeBadgeAtom: View {
    let type: String
    
    var body: some View {
        Text(type.capitalized)
            .font(.system(.subheadline, design: .rounded, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .background(backgroundColor(for: type))
            .clipShape(Capsule())
    }
    
    private func backgroundColor(for type: String) -> Color {
        switch type.lowercased() {
        case "fire": return .orange
        case "water": return .blue
        case "grass": return .green
        case "electric": return .yellow
        case "poison": return .purple
        case "psychic": return .pink
        case "normal": return .gray
        case "ground": return .brown
        case "flying": return .cyan
        case "bug": return .mint
        case "fighting": return .red
        case "rock": return .gray.opacity(0.8)
        case "ghost": return .indigo
        case "ice": return .teal
        case "dragon": return .blue.opacity(0.8)
        case "steel": return .gray.opacity(0.6)
        case "dark": return .black.opacity(0.8)
        case "fairy": return .pink.opacity(0.6)
        default: return .gray
        }
    }
}

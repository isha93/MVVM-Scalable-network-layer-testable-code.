//
//  AppColors.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

// MARK: - Color Token
/// A design token representing a semantic color.
struct ColorToken {
    let light: Color
    let dark: Color
    
    var color: Color {
        Color(UIColor { traits in
            traits.userInterfaceStyle == .dark ? UIColor(dark) : UIColor(light)
        })
    }
    
    init(_ light: Color, dark: Color? = nil) {
        self.light = light
        self.dark = dark ?? light
    }
}

// MARK: - Color System
/// Centralized color system using design tokens.
enum AppColor {
    // MARK: - Brand
    static let primary = ColorToken(.blue, dark: .blue.opacity(0.9))
    static let secondary = ColorToken(.purple, dark: .purple.opacity(0.9))
    static let accent = ColorToken(.orange, dark: .orange)
    
    // MARK: - Text
    static let textPrimary = ColorToken(Color(uiColor: .label))
    static let textSecondary = ColorToken(Color(uiColor: .secondaryLabel))
    static let textTertiary = ColorToken(Color(uiColor: .tertiaryLabel))
    static let textWhite = ColorToken(.white)
    static let textOnPrimary = ColorToken(.white)
    
    // MARK: - Background
    static let background = ColorToken(Color(uiColor: .systemBackground))
    static let backgroundSecondary = ColorToken(Color(uiColor: .secondarySystemBackground))
    static let backgroundGrouped = ColorToken(Color(uiColor: .systemGroupedBackground))
    static let cardBackground = ColorToken(.white, dark: Color(uiColor: .secondarySystemBackground))
    
    // MARK: - Semantic
    static let success = ColorToken(.green)
    static let warning = ColorToken(.orange)
    static let error = ColorToken(.red)
    static let info = ColorToken(.blue)
    
    // MARK: - Gradients
    static var cardGradient: LinearGradient {
        LinearGradient(
            colors: [primary.light.opacity(0.6), secondary.light.opacity(0.6)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    // MARK: - Pokemon Type Colors
    enum PokemonType: String, CaseIterable {
        case fire, water, grass, electric, poison, psychic
        case normal, ground, flying, bug, fighting, rock
        case ghost, ice, dragon, steel, dark, fairy
        
        var color: Color {
            switch self {
            case .fire: return .orange
            case .water: return .blue
            case .grass: return .green
            case .electric: return .yellow
            case .poison: return .purple
            case .psychic: return .pink
            case .normal: return .gray
            case .ground: return .brown
            case .flying: return .cyan
            case .bug: return .mint
            case .fighting: return .red
            case .rock: return .gray.opacity(0.8)
            case .ghost: return .indigo
            case .ice: return .teal
            case .dragon: return .blue.opacity(0.8)
            case .steel: return .gray.opacity(0.6)
            case .dark: return .black.opacity(0.8)
            case .fairy: return .pink.opacity(0.6)
            }
        }
    }
    
    static func pokemonType(_ type: String) -> Color {
        PokemonType(rawValue: type.lowercased())?.color ?? .gray
    }
    
    // MARK: - Stat Colors
    enum StatType: String {
        case hp, attack, defense
        case specialAttack = "special-attack"
        case specialDefense = "special-defense"
        case speed
        
        var color: Color {
            switch self {
            case .hp: return .red
            case .attack: return .orange
            case .defense: return .yellow
            case .specialAttack: return .blue
            case .specialDefense: return .green
            case .speed: return .pink
            }
        }
    }
    
    static func stat(_ name: String) -> Color {
        StatType(rawValue: name)?.color ?? .gray
    }
}

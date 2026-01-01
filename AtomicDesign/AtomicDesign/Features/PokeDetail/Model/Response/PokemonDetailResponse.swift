//
//  PokemonDetailResponse.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import Foundation

// MARK: - PokemonDetailResponse
struct PokemonDetailResponse: Codable, Identifiable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: PokemonSprites
    let stats: [PokemonStat]
    let types: [PokemonType]
    let abilities: [PokemonAbility]
    
    var imageUrl: URL? {
        // Prefer official artwork, fallback to front_default
        if let urlString = sprites.other?.officialArtwork.frontDefault ?? sprites.frontDefault {
            return URL(string: urlString)
        }
        return nil
    }
}

// MARK: - Sprites
struct PokemonSprites: Codable {
    let frontDefault: String?
    let other: OtherSprites?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case other
    }
}

struct OtherSprites: Codable {
    let officialArtwork: OfficialArtwork
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - Stats
struct PokemonStat: Codable, Identifiable {
    let baseStat: Int
    let effort: Int
    let stat: NamedAPIResource
    
    var id: String { stat.name }
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}

// MARK: - Types
struct PokemonType: Codable, Identifiable {
    let slot: Int
    let type: NamedAPIResource
    
    var id: String { type.name }
}

// MARK: - Abilities
struct PokemonAbility: Codable, Identifiable {
    let isHidden: Bool
    let slot: Int
    let ability: NamedAPIResource
    
    var id: String { ability.name }
    
    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case slot
        case ability
    }
}

// MARK: - Shared
struct NamedAPIResource: Codable {
    let name: String
    let url: String
}

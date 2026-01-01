//
//  PokemonImageAtom.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

/// An Atom responsible for displaying a Pokemon image safely.
/// Handles loading and error states with a unified design.
struct PokemonImageAtom: View {
    let url: URL?
    var width: CGFloat = 80
    var height: CGFloat = 80
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: width, height: height)
            case .success(let image):
                image.resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(width: width, height: height)
            case .failure:
                Image(systemName: "pawprint.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width * 0.5, height: height * 0.5)
                    .foregroundColor(.gray.opacity(0.5))
                    .frame(width: width, height: height)
            @unknown default:
                EmptyView()
            }
        }
    }
}

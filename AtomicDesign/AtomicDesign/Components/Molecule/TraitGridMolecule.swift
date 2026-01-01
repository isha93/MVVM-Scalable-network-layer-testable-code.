//
//  TraitGridMolecule.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

struct TraitGridMolecule: View {
    let height: Int
    let weight: Int
    
    var body: some View {
        HStack(spacing: 32) {
            TraitTextAtom(
                label: "Height",
                value: String(format: "%.1f M", Double(height) / 10.0)
            )
            
            Divider()
                .frame(height: 40)
            
            TraitTextAtom(
                label: "Weight",
                value: String(format: "%.1f KG", Double(weight) / 10.0)
            )
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

//
//  TraitTextAtom.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

struct TraitTextAtom: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(.title3, design: .rounded, weight: .bold))
                .foregroundColor(.primary)
            
            Text(label)
                .font(.system(.caption, design: .rounded, weight: .medium))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

//
//  StatBarAtom.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

struct StatBarAtom: View {
    let value: Int
    let maxValue: Int = 255
    let color: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 8)
                
                Capsule()
                    .fill(color)
                    .frame(width: CGFloat(value) / CGFloat(maxValue) * geometry.size.width, height: 8)
            }
        }
        .frame(height: 8)
    }
}

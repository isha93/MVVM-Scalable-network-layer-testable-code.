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
    
    @State private var animatedValue: CGFloat = 0
    
    private var targetValue: CGFloat {
        CGFloat(value) / CGFloat(maxValue)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 8)
                
                Capsule()
                    .fill(color)
                    .frame(width: animatedValue * geometry.size.width, height: 8)
            }
        }
        .frame(height: 8)
        .onAppear {
            withAnimation(.easeOut(duration: 0.8).delay(0.2)) {
                animatedValue = targetValue
            }
        }
    }
}

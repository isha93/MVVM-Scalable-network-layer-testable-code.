//
//  ScalableButtonStyle.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

/// An Atom acting as a universal interactive style.
/// Applies a scale effect on press to provide tactile feedback.
struct ScalableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == ScalableButtonStyle {
    static var scalable: ScalableButtonStyle {
        ScalableButtonStyle()
    }
}

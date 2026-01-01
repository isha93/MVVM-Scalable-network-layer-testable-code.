//
//  Typography.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

// MARK: - Font Token
/// A design token representing a complete font style.
struct FontToken {
    let font: Font
    let lineHeight: CGFloat
    let letterSpacing: CGFloat
    
    init(
        size: CGFloat,
        weight: Font.Weight = .regular,
        design: Font.Design = .rounded,
        lineHeight: CGFloat = 1.2,
        letterSpacing: CGFloat = 0
    ) {
        self.font = .system(size: size, weight: weight, design: design)
        self.lineHeight = lineHeight
        self.letterSpacing = letterSpacing
    }
}

// MARK: - Typography System
/// Centralized typography system using design tokens.
enum AppFont {
    // MARK: - Display
    static let displayLarge = FontToken(size: 48, weight: .heavy, lineHeight: 1.1)
    static let displayMedium = FontToken(size: 36, weight: .bold, lineHeight: 1.15)
    static let displaySmall = FontToken(size: 28, weight: .bold, lineHeight: 1.2)
    
    // MARK: - Headings
    static let heading1 = FontToken(size: 24, weight: .bold, lineHeight: 1.25)
    static let heading2 = FontToken(size: 20, weight: .semibold, lineHeight: 1.3)
    static let heading3 = FontToken(size: 18, weight: .semibold, lineHeight: 1.35)
    
    // MARK: - Body
    static let bodyLarge = FontToken(size: 17, weight: .regular, lineHeight: 1.5)
    static let bodyMedium = FontToken(size: 15, weight: .regular, lineHeight: 1.5)
    static let bodySmall = FontToken(size: 13, weight: .regular, lineHeight: 1.4)
    
    // MARK: - Labels
    static let labelLarge = FontToken(size: 14, weight: .semibold, lineHeight: 1.3)
    static let labelMedium = FontToken(size: 12, weight: .medium, lineHeight: 1.3)
    static let labelSmall = FontToken(size: 10, weight: .medium, lineHeight: 1.2)
    
    // MARK: - Legacy Support (Functions)
    static func title1() -> Font { displayMedium.font }
    static func title2() -> Font { heading1.font }
    static func title3() -> Font { heading2.font }
    static func headline() -> Font { heading3.font }
    static func subheadline() -> Font { labelLarge.font }
    static func body() -> Font { bodyMedium.font }
    static func caption() -> Font { labelSmall.font }
}

// MARK: - View Extension
extension View {
    /// Apply a FontToken to a view.
    func fontToken(_ token: FontToken) -> some View {
        self
            .font(token.font)
            .lineSpacing(token.lineHeight)
            .tracking(token.letterSpacing)
    }
}

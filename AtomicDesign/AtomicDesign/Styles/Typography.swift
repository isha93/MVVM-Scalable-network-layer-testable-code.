//
//  Typography.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

/// Centralized font system for the application.
enum AppFont {
    static func title1() -> Font {
        .system(.largeTitle, design: .rounded, weight: .heavy)
    }
    
    static func title2() -> Font {
        .system(.title2, design: .rounded, weight: .bold)
    }
    
    static func title3() -> Font {
        .system(.title3, design: .rounded, weight: .black)
    }
    
    static func headline() -> Font {
        .system(.headline, design: .rounded, weight: .semibold)
    }
    
    static func subheadline() -> Font {
        .system(.subheadline, design: .rounded, weight: .bold)
    }
    
    static func body() -> Font {
        .system(.body, design: .rounded, weight: .regular)
    }
}

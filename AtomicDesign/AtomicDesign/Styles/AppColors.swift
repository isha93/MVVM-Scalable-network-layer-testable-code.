//
//  AppColors.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2026/01/01.
//

import SwiftUI

/// Centralized color system for the application.
enum AppColor {
    static let primary = Color.blue
    static let secondary = Color.purple
    
    static let textPrimary = Color.primary
    static let textSecondary = Color.secondary
    static let textWhite = Color.white
    
    static let background = Color(uiColor: .systemGroupedBackground)
    static let cardBackground = Color.white
    
    static var cardGradient: LinearGradient {
        LinearGradient(
            colors: [
                primary.opacity(0.6),
                secondary.opacity(0.6)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

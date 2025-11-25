//
//  AppState.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/11/25.
//


//
//  AppState.swift
//  iosApp
//
//  Created by Isa Nur Fajar on 2025/10/16.
//  Copyright © 2025 Terra Charge. All rights reserved.
//
import Foundation
import SwiftUI

class AppState: ObservableObject {
    static let shared = AppState()
    @Published var appStateStatus: AppState.Status = .processing
    @Published var shouldShowLanguageResetDialog: Bool = false
    @Published var isLoggedIn: Bool = false

    private init() {}
    
    func forceLogout() {
        DispatchQueue.main.async {
            self.isLoggedIn = false
        }
    }
}

extension AppState {
    enum Status {
        case processing
        case landing
        case mainPage
        case chargingNowStatus
    }
}

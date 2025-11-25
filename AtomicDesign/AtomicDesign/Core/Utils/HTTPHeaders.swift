//
//  HTTPHeaders.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/11/25.
//

import Foundation
import UIKit

struct HTTPHeaders {
    /// Provides a dictionary of headers that should be attached to every API request.
    static func defaultHeaders() -> [String: String] {
        return [
            "Content-Type": "application/json",
            "app-version": appVersion,
            "api-version": "1",
            "User-Agent": userAgent,
            "time-zone": timeZone,
            "Authorization": "",
        ]
    }
    
    /// Dynamically gets the app version (e.g., "102.0.3").
    private static var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown"
    }
    
    /// Dynamically gets the current time zone identifier (e.g., "Asia/Tokyo").
    private static var timeZone: String {
        return TimeZone.current.identifier
    }
    
    /// Creates a standard User-Agent string.
    private static var userAgent: String {
        let device = UIDevice.current
        let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "App"
        return "\(appName)/\(appVersion) (\(device.systemName) \(device.systemVersion))"
    }
}

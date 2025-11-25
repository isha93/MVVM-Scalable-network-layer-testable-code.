//
//  NetworkLogger.swift
//  iosApp
//
//  Created by Isa Nur Fajar on 2025/10/14.
//  Copyright © 2025 Terra Charge. All rights reserved.
//

import Foundation

final class NetworkLogger {

    /// A runtime toggle to enable or disable logging.
    /// Set to `false` to disable all logs.
    /// Default is `true`.
    public static var isEnabled = true
    
    static func log(message: String, icon: String) {
        guard isEnabled else { return }
        print("[\(icon)] \(message)")
    }
    
    static func log(request: URLRequest) {
        guard isEnabled else { return }

        print("\n------------------ 🚀 OUTGOING ------------------")
        defer { print("------------------------------------------------\n") }

        let urlString = request.url?.absoluteString ?? "N/A"
        let method = request.httpMethod ?? "N/A"

        var output = """
        URL: \(urlString)
        METHOD: \(method)
        """
        
        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            output += "\nHEADERS:\n\(prettyPrint(dictionary: headers))"
        }

        if let body = request.httpBody {
            if let prettyBody = prettyPrint(data: body) {
                output += "\nBODY:\n\(prettyBody)"
            } else {
                output += "\nBODY (RAW):\n\(String(data: body, encoding: .utf8) ?? "Non-UTF8 data")"
            }
        }

        print(output)
    }
    
    static func log(response: HTTPURLResponse, data: Data) {
        guard isEnabled else { return }

        let icon: String
        switch response.statusCode {
        case 200..<300: icon = "✅ SUCCESS"
        case 400..<500: icon = "⚠️ CLIENT ERROR"
        default: icon = "❌ SERVER ERROR"
        }
        
        print("\n------------------ \(icon) ------------------")
        defer { print("------------------------------------------------\n") }

        let urlString = response.url?.absoluteString ?? "N/A"

        var output = """
        URL: \(urlString)
        STATUS: \(response.statusCode)
        """
        
        if let headers = response.allHeaderFields as? [String: Any], !headers.isEmpty {
            output += "\nHEADERS:\n\(prettyPrint(dictionary: headers))"
        }
        
        if data.isEmpty {
            output += "\nBODY: [Empty]"
        } else if let prettyBody = prettyPrint(data: data) {
            output += "\nBODY:\n\(prettyBody)"
        } else {
            output += "\nBODY (RAW):\n\(String(data: data, encoding: .utf8) ?? "Non-UTF8 data")"
        }
        
        print(output)
    }
    
    // MARK: - Private Helpers
    
    private static func prettyPrint(data: Data) -> String? {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
              let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
              let prettyString = String(data: prettyData, encoding: .utf8) else {
            return nil
        }
        return prettyString
    }
    
    private static func prettyPrint(dictionary: [String: Any]) -> String {
        return dictionary.map { key, value in "  \(key): \(value)" }.joined(separator: "\n")
    }
}

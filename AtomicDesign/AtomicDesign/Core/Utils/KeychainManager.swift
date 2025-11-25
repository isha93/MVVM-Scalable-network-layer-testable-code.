//
//  to.swift
//  AtomicDesign
//
//  Created by Isa Nur Fajar on 2025/11/25.
//


import Foundation
import Security

/// An enum to provide type-safe keys for Keychain access.
/// This prevents typos when using string literals.
enum KeychainKey: String, CaseIterable {
    case accessToken
    case refreshToken
    case userUUID
}

/// A secure manager for handling sensitive data using the system Keychain.
final class KeychainManager {
    static let shared = KeychainManager()
    private let serviceName = Bundle.main.bundleIdentifier ?? "com.terracharge.app"
    
    private init() {}
    // MARK: - Public Methods
    
    /// Saves a string value securely to the Keychain for a specific key.
    /// If a value already exists for the key, it will be updated.
    /// - Parameters:
    ///   - value: The string value to save.
    ///   - key: The `KeychainKey` to associate with the value.
    func save(_ value: String, forKey key: KeychainKey) {
        guard let data = value.data(using: .utf8) else {
            print("🚨 Keychain Error: Unable to convert value to Data for key '\(key.rawValue)'.")
            return
        }
        let query = makeQuery(forKey: key)
        
        let attributes: [String: Any] = [
            kSecValueData as String: data
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        
        if status == errSecItemNotFound {
            var newQuery = query
            newQuery[kSecValueData as String] = data
            let addStatus = SecItemAdd(newQuery as CFDictionary, nil)
            
            if addStatus != errSecSuccess {
                print("🚨 Keychain Error: Failed to save new item for key '\(key.rawValue)'. Status: \(addStatus)")
            } else {
                print("✅ Keychain: New item saved for key '\(key.rawValue)'.")
            }
        } else if status != errSecSuccess {
            print("🚨 Keychain Error: Failed to update item for key '\(key.rawValue)'. Status: \(status)")
        } else {
            print("✅ Keychain: Item updated for key '\(key.rawValue)'.")
        }
    }
    
    /// Retrieves a string value from the Keychain for a specific key.
    /// - Parameter key: The `KeychainKey` of the value to retrieve.
    /// - Returns: The string value if it exists, otherwise `nil`.
    func getValue(forKey key: KeychainKey) -> String? {
        var query = makeQuery(forKey: key)
        query[kSecReturnData as String] = kCFBooleanTrue!
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess {
            guard let data = dataTypeRef as? Data,
                  let value = String(data: data, encoding: .utf8) else {
                return nil
            }
            return value
        } else if status != errSecItemNotFound {
            print("⚠️ Keychain Warning: Failed to retrieve item for key '\(key.rawValue)'. Status: \(status)")
        }
        
        return nil
    }
    
    /// Deletes a value from the Keychain for a specific key.
    /// - Parameter key: The `KeychainKey` of the value to delete.
    func deleteValue(forKey key: KeychainKey) {
        let query = makeQuery(forKey: key)
        let status = SecItemDelete(query as CFDictionary)
        
        if status != errSecSuccess && status != errSecItemNotFound {
            print("🚨 Keychain Error: Failed to delete item for key '\(key.rawValue)'. Status: \(status)")
        } else {
            print("🗑️ Keychain: Item deleted for key '\(key.rawValue)'.")
        }
    }
    
    /// Deletes all values managed by this class from the Keychain.
    /// This is useful for handling a user logout.
    func deleteAll() {
        print("🗑️ Keychain: Deleting all saved items...")
        for key in KeychainKey.allCases {
            deleteValue(forKey: key)
        }
    }
    
    // MARK: - Private Helper
    
    /// Creates a base dictionary query for keychain operations.
    private func makeQuery(forKey key: KeychainKey) -> [String: Any] {
        return [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: key.rawValue
        ]
    }
}

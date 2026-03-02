//
//  KeychainUtils.swift
//  HockeyApp
//
//  Created by Yoji on 03.09.2025.
//
import Foundation

final class KeychainUtils {
    static var shared = KeychainUtils()
    
    enum Label: String {
        case email = "email"
        case token = "token"
    }
    
    func encode(key: String) {
        var array:[UInt8] = []
        key.data(using: .utf8)?.forEach { byte in
            array.append(byte)
        }
        print(array)
    }
    
    private func decode(array: [UInt8]?) -> String? {
        guard let array else { return nil }
        return String(data: Data(array), encoding: .utf8)
    }
    
    private func addKeyToKeychain(key: [UInt8], label: String) -> [UInt8] {
        let keyData = Data(key)
        let keychainItemQuery: [String: Any] = [
            kSecValueData as String: keyData,
            kSecAttrLabel as String: label,
            kSecClass as String: kSecClassKey
        ]
        
        _ = SecItemAdd(keychainItemQuery as CFDictionary, nil)
        return key
    }
    
    func getFromKeychain(label: Label) -> String? {
        let keychainSearchingQuery: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrLabel as String: label.rawValue,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(keychainSearchingQuery as CFDictionary, &item)
        guard status != errSecItemNotFound else {
            var key: [UInt8]
            switch label {
            case .email:
                key = [119, 98, 103, 115, 112, 115, 101, 106, 117, 100, 100, 117, 99, 109, 101, 121]
                let addedKey = self.addKeyToKeychain(key: key, label: label.rawValue)
                return decode(array: addedKey)
            case .token:
                return nil
            }
        }
        
        guard let keyData = item as? Data else {
            return nil
        }
        
        let key: [UInt8] = Array(keyData)
        return decode(array: key)
    }
    
    func addStringToKeychain(key: String, label: Label) -> String {
        let keychainItemQuery: [String: Any] = [
            kSecValueData as String: key,
            kSecAttrLabel as String: label.rawValue,
            kSecClass as String: kSecClassKey
        ]
        
        _ = SecItemAdd(keychainItemQuery as CFDictionary, nil)
        return key
    }
}

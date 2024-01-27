import Foundation
import Security

struct SessionTokenInteractor {
    // With this setup we want to make sure that the identifier is not guessable by other apps.
    private let ADVENT_OF_CODE_IDENTIFIER = "ADVENT_OF_CODE_SESSION_IDENTIFIER"
    
    func setSessionToken(token: String) -> Bool {
        let keychainItem = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: ADVENT_OF_CODE_IDENTIFIER,
            kSecValueData: token.data(using: .utf8)!,
            kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked
        ] as CFDictionary
        
        let status = SecItemAdd(keychainItem, nil)
        
        if status == errSecSuccess {
            return true
        } else {
            print("Error setting token in Keychain \(status)")
            return false
        }
    }
    
    func getSessionToken() -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: ADVENT_OF_CODE_IDENTIFIER,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        var retrievedData: CFTypeRef?
        
        let status = SecItemCopyMatching(query, &retrievedData)
        
        if status == errSecSuccess, let data = retrievedData as? Data {
            return String(data: data, encoding: .utf8)
        } else {
            print("No token in keychain found: \(status)")
            return nil
        }
    }
}

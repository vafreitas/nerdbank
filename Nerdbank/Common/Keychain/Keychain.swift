//
//  Keychain.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 25/09/22.
//

import KeychainSwift
import Foundation

class Keychain {
    private var keychain = KeychainSwift()
    
    static var shared: Keychain = {
        let keychain = Keychain()
        return keychain
    }()
    
    func get<D: Codable>(_ key: String, _ type: D.Type) -> D? {
        guard let data = keychain.getData(key) else {
            return nil
        }
        
        do {
            let model = try JSONDecoder().decode(type, from: data)
            return model
        } catch {
            return nil
        }
    }
    
    func set<D: Codable>(_ key: String, _ object: D) {
        do {
            let data = try JSONEncoder().encode(object)
            keychain.set(data, forKey: key)
        } catch {
            debugPrint("Error to save object in keychain")
        }
    }
    
    @discardableResult
    func clear() -> Bool {
        keychain.clear()
    }
}

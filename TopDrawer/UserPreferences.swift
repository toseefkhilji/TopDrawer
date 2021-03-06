//
//  UserPreferences.swift
//  MenuNav
//
//  Created by Steve Barnegren on 10/09/2017.
//  Copyright © 2017 SteveBarnegren. All rights reserved.
//

import Foundation

protocol KeyValueStorable {}
extension String: KeyValueStorable {}
extension Bool: KeyValueStorable {}
extension Int: KeyValueStorable {}

protocol KeyValueStore {

    func set(value: Any, forKey key: String)
    func value(forKey key: String) -> Any?
    
    func set(bool: Bool, forKey key: String)
    func bool(forKey key: String) -> Bool?
    
    func set(string: String, forKey key: String)
    func string(forKey key: String) -> String?
    
    func set(int: Int, forKey key: String)
    func int(forKey key: String) -> Int?
}

// UserPreferences is a wrapper for UserDefaults, adopting the KeyValueStore protocol
class UserPreferences: KeyValueStore {
    
    let userDefaults = UserDefaults.standard
    
    func set(value: Any, forKey key: String) {
        userDefaults.set(value, forKey: transform(key: key))
        userDefaults.synchronize()
    }
    
    func value(forKey key: String) -> Any? {
        return userDefaults.value(forKey: transform(key: key))
    }
    
    func set(bool: Bool, forKey key: String) {
        userDefaults.set(bool, forKey: transform(key: key))
        userDefaults.synchronize()
    }
    
    func bool(forKey key: String) -> Bool? {
        return userDefaults.value(forKey: transform(key: key)) as? Bool
    }
    
    func set(string: String, forKey key: String) {
        userDefaults.set(string, forKey: transform(key: key))
        userDefaults.synchronize()
    }
    
    func string(forKey key: String) -> String? {
        return userDefaults.value(forKey: transform(key: key)) as? String
    }
    
    func set(int: Int, forKey key: String) {
        userDefaults.set(int, forKey: transform(key: key))
        userDefaults.synchronize()
    }
    
    func int(forKey key: String) -> Int? {
        return userDefaults.value(forKey: transform(key: key)) as? Int
    }
    
    func transform(key: String) -> String {
        // Transforms the keys for debugging,
        // so that debug / production data is separate
        #if DEBUG
            return "debug_\(key)"
        #else
            return key
        #endif
    }
}

//
//  Setting.swift
//  MenuNav
//
//  Created by Steve Barnegren on 29/04/2017.
//  Copyright © 2017 SteveBarnegren. All rights reserved.
//

import Foundation
import AppKit
import ServiceManagement

fileprivate let userDefaults = UserDefaults.standard

class Settings {
    
    // MARK: - Internal
    
    static var path: String? {
        get{
            return userDefaults.object(forKey: #function) as? String
        }
        set{
            userDefaults.setValue(newValue, forKey: #function)
            userDefaults.synchronize()
        }
    }
    
    static var openAtLogin: Bool {
        get {
            return userDefaults.bool(forKey: #function)
        }
        set {
            
            guard let bundleId = Bundle.main.bundleIdentifier else {
                fatalError("Cannot find application bundle id")
            }
            
            SMLoginItemSetEnabled(bundleId as CFString, openAtLogin)
            userDefaults.set(openAtLogin, forKey: #function)
        }
    }
}

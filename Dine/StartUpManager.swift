//
//  StartUpManager.swift
//  Dine
//
//  Created by doss-zstch1212 on 07/02/24.
//

import Foundation

class StartUpManager {
    private let userDefaults = UserDefaults.standard
    private let firstStartKey = "isFirstStart"
    private let userLoginKey = "isUserLoggedIn"
    
    func isFirstStart() -> Bool {
        return !userDefaults.bool(forKey: firstStartKey)
    }
    
    func isUserLoggedIn() -> Bool {
        return !userDefaults.bool(forKey: userLoginKey)
    }
    
    func changeValue(isUserLoggedIn: Bool) {
        userDefaults.setValue(isUserLoggedIn, forKey: userLoginKey)
    }
    
    func changeValue(isFirstStartUp: Bool) {
        userDefaults.setValue(isFirstStartUp, forKey: firstStartKey)
    }
}

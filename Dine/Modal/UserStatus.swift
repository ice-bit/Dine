//
//  UserStatus.swift
//  Dine
//
//  Created by doss-zstch1212 on 26/02/24.
//

/// - isUserLoggedIn
/// - isInitialStartUp
/// - restaurantExists

import Foundation

@frozen enum UserStatus: String {
    case userLoggedIn = "userLoggedIn_v1.7"
    case initialSetup = "initialSetup_v1.4"
    case restaurantExists = "restaurantExists_v1.0"
    
    func getStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: self.rawValue)
    }
    
    func updateStatus(_ status: Bool) {
        UserDefaults.standard.set(status, forKey: self.rawValue)
    }
}

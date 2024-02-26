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
    case userLoggedIn = "T1"
    case initialSetup = "S2"
    case restaurantExists = "R1"
    
    func getStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: self.rawValue)
    }
    
    func updateStatus(_ status: Bool) {
        UserDefaults.standard.set(status, forKey: self.rawValue)
    }
}

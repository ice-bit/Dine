//
//  UserStatus.swift
//  Dine
//
//  Created by doss-zstch1212 on 14/02/24.
//

import Foundation

@frozen enum UserStatus: String {
    case userLoggedIn = "isUserLoggedInTest3"
    case initialSetup = "isInitialStartUpTest3"
    case restaurantSetup = "isRestaurantSetUpTest3"
    
    func getStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: self.rawValue)
    }
    
    func updateStatus(_ status: Bool) {
        UserDefaults.standard.set(status, forKey: self.rawValue)
    }
}

//
//  LoginController.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class LoginController {
    private let userManager: UserManagabale
    
    init(userManager: UserManagabale) {
        self.userManager = userManager
    }
    
    func authenticateUserCredentials(username: String, password: String) -> Bool {
        guard userManager.checkUserPresence(username) else {
            print("No user found in this username!")
            return false
        }
        
        // Check whether the password is matching.
        if let account = userManager.searchUser(username), account.verifyPassword(password) {
            return true
        } else {
            print("Search failed! No account under \(username) found!")
            return false
        }
    }
    
    // TODO: Write method to log user into the system...
}

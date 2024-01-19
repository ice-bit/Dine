//
//  EditAccountController.swift
//  Dine
//
//  Created by doss-zstch1212 on 08/01/24.
//

import Foundation

class EditAccountController {
    private let userManager: UserManagabale
    
    init(userManager: UserManagabale) {
        self.userManager = userManager
    }
    
    func changePassword(username: String, password: String) -> Bool {
        guard userManager.checkUserPresence(username) else {
            print("No users found under this usernamec")
            return false
        }
        
        guard AuthenticationValidator.isStrongPassword(password) else {
            print("Password not strong enough!")
            return false
        }
        
        if let user = userManager.searchUser(username) {
            user.updatePassword(password)
            return true
        } else {
            print("Failed to update the password")
            return false
        }
    }
}

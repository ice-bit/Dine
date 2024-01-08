//
//  SignUpController.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class SignUpController {
    private let userManager: UserManagabale
    
    init(userManager: UserManagabale) {
        self.userManager = userManager
    }
    
    func createAccount(username: String, password: String, role: UserRole) -> Bool {
        guard AuthenticationValidator.isValidUsername(username) else {
            print("Invalid username. Please follow the username criteria.")
            return false
        }
        
        guard AuthenticationValidator.isStrongPassword(password) else {
            print("Password is not strong enough. Please follow the password requirements.")
            return false
        }
        
        guard !userManager.checkUserPresence(username) else {
            print("Username already exists!")
            return false
        }
        
        let newAccount = Account(id: username, password: password, accountStatus: .active, userRole: role)
        
        userManager.addUser(newAccount)
        return true
    }
}


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
        guard isValidUsername(username) else {
            print("Invalid username. Please follow the username criteria.")
            return false
        }
        
        guard isStrongPassword(password) else {
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
    
    private func isStrongPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return predicate.evaluate(with: password)
    }
    
    // This regex checks if the username consists of only alphanumeric characters
    // and underscores, with a length between 3 and 20 characters.
    private func isValidUsername(_ username: String) -> Bool {
        let usernameRegex = "^[a-zA-Z0-9_]{3,20}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        return predicate.evaluate(with: username)
    }
}

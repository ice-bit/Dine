//
//  AuthorizationController.swift
//  Dine
//
//  Created by doss-zstch1212 on 18/03/24.
//

import Foundation

struct AuthorizationController: Authentication {
    private let databaseAccess: DatabaseAccess
    init(databaseAccess: DatabaseAccess) {
        self.databaseAccess = databaseAccess
    }

    func createAccount(username: String, password: String, userRole: UserRole) throws {
        guard AuthenticationValidator.isValidUsername(username) else {
            throw AuthenticationError.invalidUsername(reason: "Invalid username format. Use letters, numbers, and underscores only (3-20 characters).")
        }
        guard AuthenticationValidator.isStrongPassword(password) else {
            throw AuthenticationError.invalidPassword(reason: "Weak password. Must be at least 8 characters with uppercase, lowercase, digit, and special character.")
        }
        
    }
    
    func login(username: String, password: String) -> Bool {
        true
    }
    
    
}

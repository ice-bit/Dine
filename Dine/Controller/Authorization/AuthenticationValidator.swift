//
//  AuthenticationValidator.swift
//  Dine
//
//  Created by doss-zstch1212 on 08/01/24.
//
//Using static methods can provide a more straightforward API if you don't need to maintain any internal state in the AuthenticationValidator instances.

import Foundation

class AuthenticationValidator {
    static func isStrongPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return predicate.evaluate(with: password)
    }
    
    // This regex checks if the username consists of only alphanumeric characters
    // and underscores, with a length between 3 and 20 characters.
    static func isValidUsername(_ username: String) -> Bool {
        let usernameRegex = "^[a-zA-Z0-9_]{3,20}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        return predicate.evaluate(with: username)
    }
}

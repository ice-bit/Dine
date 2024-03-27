//
//  AuthenticationValidator.swift
//  Dine
//
//  Created by doss-zstch1212 on 08/01/24.
//
//Using static methods can provide a more straightforward API if you don't need to maintain any internal state in the AuthenticationValidator instances.

import Foundation
/// Utility class for validating user authentication credentials.
class AuthenticationValidator {
    /// Determines whether a given password is strong.
    ///
    /// A strong password must:
    /// - Contain at least one uppercase letter.
    /// - Contain at least one lowercase letter.
    /// - Contain at least one digit.
    /// - Contain at least one special character from the set: @$!%*?&.
    /// - Have a minimum length of 8 characters.
    ///
    /// - Parameter password: The password string to validate.
    /// - Returns: `true` if the password is strong; otherwise, `false`.
    static func isStrongPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return predicate.evaluate(with: password)
    }
    
    /// Determines whether a given username is valid.
    ///
    /// A valid username must:
    /// - Contain only alphanumeric characters and underscores.
    /// - Have a length between 3 and 20 characters.
    ///
    /// - Parameter username: The username string to validate.
    /// - Returns: `true` if the username is valid; otherwise, `false`.
    static func isValidUsername(_ username: String) -> Bool {
        let usernameRegex = "^[a-zA-Z0-9_]{3,20}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        return predicate.evaluate(with: username)
    }
}

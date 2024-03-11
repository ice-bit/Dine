//
//  AuthenticationError.swift
//  Dine
//
//  Created by doss-zstch1212 on 15/02/24.
//

import Foundation

enum AuthenticationError: Error {
    case invalidUsername
    case invalidPassword
    case inactiveAccount
    case userAlreadyExists
    case noUserFound
    case weakPasswordError
    case passwordReuseError
    case other(Error)
    
    func handleLoginError() {
        switch self {
        case .invalidUsername:
            print("Invalid username")
        case .invalidPassword:
            print("Invalid password")
        case .userAlreadyExists:
            print("User already exists")
        case .inactiveAccount:
            print("Inactive account")
        case .noUserFound:
            print("No user found under username")
        case .passwordReuseError:
            print("Password is being reused")
        case .weakPasswordError:
            print("Provide strong password")
        case .other(let error):
            print("An error occurred: \(error.localizedDescription)")
        }
    }
}

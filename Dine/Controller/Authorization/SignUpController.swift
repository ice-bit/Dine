//
//  SignUpController.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

enum AuthenticationError: Error {
    case invalidUsername
    case invalidPassword
    case inactiveAccount
    case userAlreadyExists
}

class SignUpController {
    private let userManager: UserManagabale
    
    init(userManager: UserManagabale) {
        self.userManager = userManager
    }
    
    func createAccount(username: String, password: String, role: UserRole) throws {
        guard !userManager.checkUserPresence(username) else {
            throw AuthenticationError.userAlreadyExists
        }
        
        guard AuthenticationValidator.isValidUsername(username) else {
            throw AuthenticationError.invalidUsername
        }
        
        guard AuthenticationValidator.isStrongPassword(password) else {
            throw AuthenticationError.invalidPassword
        }
        
//        let newAccount = Account(username: username, password: password, accountStatus: .active, userRole: role)
//        
//        userManager.addUser(newAccount)
    }
    
    func initiateAccountRegistration() throws {
        guard let username = UserPrompter.getUserInput(prompt: "Enter new username: ") else { return }
        
        guard let password = UserPrompter.getUserInput(prompt: "Enter new password: ") else { return }
        
        try createAccount(username: username, password: password, role: .manager)
    }
    
//    func handleSignUpError(_ error: AuthenticationError) {
//        switch error {
//        case .invalidUsername:
//            print("Invalid username. Please follow the username criteria.")
//        case .invalidPassword:
//            print("Password is not strong enough. Please follow the password requirements.")
//        case .userAlreadyExists:
//            print("Username already exists!")
//        /*case .invalidInput:
//            print("Invalid input")*/
//        }
//    }
    
    
    
}


//
//  SignUpController.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

enum SignUpError: Error {
    case invalidUsername
    case invalidPassword
    //case invalidInput
    case userAlreadyExists
}

class SignUpController {
    private let userManager: UserManagabale
    
    init(userManager: UserManagabale) {
        self.userManager = userManager
    }
    
    private func createAccount(username: String, password: String, role: UserRole) throws {
        guard AuthenticationValidator.isValidUsername(username) else {
            throw SignUpError.invalidUsername
        }
        
        guard !userManager.checkUserPresence(username) else {
            throw SignUpError.userAlreadyExists
        }
        
        guard AuthenticationValidator.isStrongPassword(password) else {
            throw SignUpError.invalidPassword
        }
        
        let newAccount = Account(id: username, password: password, accountStatus: .active, userRole: role)
        
        userManager.addUser(newAccount)
    }
    
    func initiateAccountRegistration() throws {
        let signUpConsoleView = SignUpConsoleView()
        guard let username = signUpConsoleView.promptUsername() else {
            return
        }
        
        guard let password = signUpConsoleView.promptPassword() else {
            return
        }
        
        try createAccount(username: username, password: password, role: .manager)
    }
    
    func handleSignUpError(_ error: SignUpError) {
        switch error {
        case .invalidUsername:
            print("Invalid username. Please follow the username criteria.")
        case .invalidPassword:
            print("Password is not strong enough. Please follow the password requirements.")
        case .userAlreadyExists:
            print("Username already exists!")
        /*case .invalidInput:
            print("Invalid input")*/
        }
    }
    
}


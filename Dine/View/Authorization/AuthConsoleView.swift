//
//  AuthConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 23/01/24.
//

import Foundation

protocol LoginStateDelegate: AnyObject {
    func isUserLoggedIn(_ state: Bool)
}

class AuthConsoleView {
    private let userRepository: UserRepository
    
    weak var delegate: LoginStateDelegate?
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func startSignUp() {
        promptSignUpCredentials(isInitial: true)
    }
    
    func startLogin() {
        promptLoginCredentials()
    }
    
    func createEmployee() {
        promptSignUpCredentials(isInitial: false)
    }
    
    private func promptSignUpCredentials(isInitial: Bool) {
        let userRole: UserRole
        if isInitial {
            userRole = .manager
        } else {
            userRole = .employee
        }
        print("Enter your credentials")
        print("New Username:")
        let username = readLine() ?? ""
        print("New Password:")
        let password = readLine() ?? ""
        
        let authController = AuthController(userRepository: userRepository)
        do {
            try authController.createAccount(username: username, password: password, userRole: userRole)
            print("Account successfully created")
        } catch AuthenticationError.userAlreadyExists {
            print("Failed to create account. User already exists.")
        } catch AuthenticationError.invalidUsername {
            print("Invalid username. Please enter a valid username.")
        } catch AuthenticationError.invalidPassword {
            print("Invalid password. Password must be at least 8 characters long and contain a combination of letters, numbers, and special characters.")
        } catch {
            print("An unexpected error occurred: \(error)")
        }
    }
    
    private func promptLoginCredentials() {
        print("Enter your credentials")
        print("Username:")
        let username = readLine() ?? ""
        print("Password:")
        let password = readLine() ?? ""
        
        let authController = AuthController(userRepository: userRepository)
        if authController.login(username: username, password: password) {
            delegate?.isUserLoggedIn(true)
            print("Logged in successfully.")
        } else {
            print("Login failed")
            promptLoginCredentials()
        }
    }
}

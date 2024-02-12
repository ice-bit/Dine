//
//  AuthConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 23/01/24.
//

import Foundation

class AuthConsoleView {
    private let userRepository: UserRepository
    
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
        if authController.createAccount(username: username, password: password, userRole: userRole) {
            print("Account successfully created")
        } else {
            print("Failed to create account")
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
            print("Logged in successfully.")
        } else {
            print("Login failed")
            promptLoginCredentials()
        }
    }
}

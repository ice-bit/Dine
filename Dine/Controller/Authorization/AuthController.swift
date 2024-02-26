//
//  AuthController.swift
//  Dine
//
//  Created by doss-zstch1212 on 10/01/24.
//

import Foundation

protocol Authentication {
    func createAccount(username: String, password: String, userRole: UserRole) throws
    func login(username: String, password: String) -> Bool
}

class AuthController: Authentication {
    private let userRepository: UserRepository = InMemoryUserRepository.shared
    
    func createAccount(username: String, password: String, userRole: UserRole) throws {
        guard !userRepository.checkUserPresence(username: username) else { throw AuthenticationError.userAlreadyExists }
        guard AuthenticationValidator.isValidUsername(username) else { throw AuthenticationError.invalidUsername }
        guard AuthenticationValidator.isStrongPassword(password) else { throw AuthenticationError.invalidPassword }
        
        let account = Account(username: username, password: password, accountStatus: .active, userRole: userRole)
        
        // Add the new user to the memory
        userRepository.addUser(account)
        UserStatus.initialSetup.updateStatus(false)
        UserStatus.userLoggedIn.updateStatus(true)
    }
    
    func login(username: String, password: String) -> Bool {
        do {
            let authenticationManager = AuthenticationManager(userRespository: userRepository)
            let isValidLogin =  try authenticationManager.isLoginValid(username: username, password: password)
            if isValidLogin {
                //UserStatus.userLoggedIn.updateStatus(true)
                return true
            }
        } catch {
            if let authError = error as? AuthenticationError {
                switch authError {
                case .invalidUsername:
                    print("Invalid username")
                case .invalidPassword:
                    print("Invalid password")
                case .userAlreadyExists:
                    print("User already exist")
                case .inactiveAccount:
                    print("Inactive account")
                case .noUserFound:
                    print("No user found under username: \(username)")
                }
            } else {
                print("An error occurred: \(error.localizedDescription)")
            }
        }
        
        return false
    }
    
}

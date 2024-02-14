//
//  AuthController.swift
//  Dine
//
//  Created by doss-zstch1212 on 10/01/24.
//

import Foundation

class AuthController {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func createAccount(username: String, password: String, userRole: UserRole) throws {
        guard !userRepository.checkUserPresence(username: username) else { throw AuthenticationError.userAlreadyExists }
        guard AuthenticationValidator.isValidUsername(username) else { throw AuthenticationError.invalidUsername }
        guard AuthenticationValidator.isStrongPassword(password) else { throw AuthenticationError.invalidPassword }
        
        let account = Account(username: username, password: password, accountStatus: .active, userRole: userRole)
        
        userRepository.addUser(account)
        UserStatus.userLoggedIn.updateStatus(true)
    }
    
    func login(username: String, password: String) -> Bool {
        do {
            let authenticationManager = AuthenticationManager(userRespository: userRepository)
            let isValidLogin =  try authenticationManager.isLoginValid(username: username, password: password)
            if isValidLogin {
                UserStatus.userLoggedIn.updateStatus(true)
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
                }
            } else {
                print("An error occurred: \(error.localizedDescription)")
            }
        }
        
        return false
    }
    
}

enum AuthenticationError: Error {
    case invalidUsername
    case invalidPassword
    case inactiveAccount
    case userAlreadyExists
}

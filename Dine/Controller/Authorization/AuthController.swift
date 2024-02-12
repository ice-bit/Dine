//
//  AuthController.swift
//  Dine
//
//  Created by doss-zstch1212 on 10/01/24.
//

import Foundation

class AuthController {
    
    /*/// Creates new account and save it to file.
    func createAccount(username: String, password: String, userRole: UserRole) -> Bool {
        // Check if username already exists
        guard !FileIOService.fileExists(withName: "\(username).json") else {
            print("Admin with \(username) already exists!")
            return false
        }
        
        // Validate username
        guard AuthenticationValidator.isValidUsername(username) else {
            print("Invalid username!")
            return false
        }
        
        // Validate password strength
        guard AuthenticationValidator.isStrongPassword(password) else {
            print("Password not strong enough!")
            return false
        }
        
        let account = Account(username: username, password: password, accountStatus: .active, userRole: userRole)
        
        // Save account to file
        if FileIOService.saveDataToFile(data: account, fileName: "\(username).json") {
            print("Successfully saved account to file.")
            return true
        } else {
            print("Fialed to save account to file.")
        }
        
        return true
    }
    
    /// Validates the credentials for login.
    func validateLogin(username: String, password: String) -> Bool {
        guard FileIOService.fileExists(withName: "\(username).json") else {
            print("User doesn't exists.")
            return false
        }
        
        do {
            if let account: Account = try FileIOService.readDataFromFile(fileName: "\(username).json") {
                if account.getPassword() == password {
                    print("Logged in successfuly.")
                    return true
                } else {
                    print("Logging failed for user: \(username).")
                    return false
                }
            }
        } catch {
            print("Error encountered: \(error)")
        }
        
        return true
    }*/
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func createAccount(username: String, password: String, userRole: UserRole) -> Bool {
        if userRepository.checkUserPresence(username: username) {
            print("User already exist")
            return false
        }
        guard AuthenticationValidator.isValidUsername(username) else { return false }
        guard AuthenticationValidator.isStrongPassword(password) else { return false }
        
        let account = Account(username: username, password: password, accountStatus: .active, userRole: userRole)
        
        userRepository.addUser(account)
        return true
    }
    
    func login(username: String, password: String) -> Bool {
        do {
            let authenticationManager = AuthenticationManager(userRespository: userRepository)
            let isValidLogin =  try authenticationManager.isLoginValid(username: username, password: password)
            if isValidLogin {
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

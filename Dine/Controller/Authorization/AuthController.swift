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
        UserStatus.initialSetup.updateStatus(true)
        UserStatus.userLoggedIn.updateStatus(true)
    }
    
    func login(username: String, password: String) -> Bool {
        let result = isLoginValid(username: username, password: password)

        switch result {
        case .success(let account):
            UserStore.setUser(account: account)
            UserStatus.userLoggedIn.updateStatus(true)
            return true
        case .failure(let error):
            handleLoginError(error, username: username)
            return false
        }
    }
    
    private func handleLoginError(_ error: AuthenticationError, username: String) {
        switch error {
        case .invalidUsername:
            print("Invalid username")
        case .invalidPassword:
            print("Invalid password")
        case .userAlreadyExists:
            print("User already exists")
        case .inactiveAccount:
            print("Inactive account")
        case .noUserFound:
            print("No user found under username: \(username)")
        case .passwordReuseError:
            print("Password is being reused")
        case .weakPasswordError:
            print("Provide strong password")
        case .other(let error):
            print("An error occurred: \(error.localizedDescription)")
        }
    }
    
    private func isLoginValid(username: String, password: String) -> Result<Account, AuthenticationError> {
        do {
            guard let user = userRepository.searchUser(username: username) else {
                throw AuthenticationError.noUserFound
            }
            
            guard user.accountStatus == .active else {
                throw AuthenticationError.inactiveAccount
            }
            
            guard user.password == password else {
                throw AuthenticationError.invalidPassword
            }
            
            return .success(user)
        } catch let error as AuthenticationError {
            return .failure(error)
        } catch {
            return .failure(.other(error))
        }
    }

    
}

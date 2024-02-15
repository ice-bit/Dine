//
//  EditAccountController.swift
//  Dine
//
//  Created by doss-zstch1212 on 08/01/24.
//

import Foundation

class EditAccountController {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func changePassword(username: String, password: String) -> Bool {
        guard userRepository.checkUserPresence(username: username) else {
            print("No users found under this usernamec")
            return false
        }
        
        guard AuthenticationValidator.isStrongPassword(password) else {
            print("Password not strong enough!")
            return false
        }
        
        if let user = userRepository.searchUser(username: username) {
            user.updatePassword(password)
            return true
        } else {
            print("Failed to update the password")
            return false
        }
    }
}

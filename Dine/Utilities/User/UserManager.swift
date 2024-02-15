//
//  UserManager.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class UserManager {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func addUser(_ user: Account) {
        userRepository.addUser(user)
    }
    
    func removeUser(_ user: Account) throws {
        try userRepository.removeUser(user)
    }
    
    func checkUserPresence(username: String) -> Bool {
        return userRepository.checkUserPresence(username: username)
    }
    
    func searchUser(username: String) -> Account? {
        return userRepository.searchUser(username: username)
    }
    
    func isUserActive(username: String) -> Bool {
        return userRepository.isUserActive(username: username)
    }
    
    func isManager(username: String) -> Bool {
        return userRepository.isManager(username: username)
    }
}

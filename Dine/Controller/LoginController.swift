//
//  LoginController.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class LoginController {
    private let usernameManager: UserManagabale
    
    init(usernameManager: UserManagabale) {
        self.usernameManager = usernameManager
    }
    
    func LoginUser(username: String, password: String) -> Bool {
        guard usernameManager.checkUserPresence(username) else {
            print("No user found in this username!")
            return false
        }
        
        if let account = usernameManager.searchUser(username), account.verifyPassword(password) {
            return true
        } else {
            print("Search failed! No account under \(username) found!")
            return false
        }
    }
}

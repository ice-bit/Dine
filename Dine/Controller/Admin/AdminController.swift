//
//  AdminController.swift
//  Dine
//
//  Created by doss-zstch1212 on 23/01/24.
//

import Foundation

protocol AdminPrivilages {
    func removeAccount(user: Account) -> Bool
    func getAccounts() -> [Account]?
}

struct AdminController: AdminPrivilages {
    private let accounts: UserRepository = InMemoryUserRepository.shared
    
    func removeAccount(user: Account) -> Bool {
        do {
            try accounts.removeUser(user)
            return true
        } catch {
            print("Failed to remove: \(error)")
            return false
        }
    }
    
    /*func removeAccount(username: String, password: String) -> Bool {
        
    }*/
    
    func getAccounts() -> [Account]? {
        let users = accounts.getAccounts()
        guard !users.isEmpty else { return nil }
        return users
    }
    
}

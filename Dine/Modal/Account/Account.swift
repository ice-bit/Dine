//
//  Account.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

enum AccountStatus: Int, Codable {
    case active = 1
    case closed = 2
    case cancelled = 3
}

enum UserRole: Codable {
    case manager, waitStaff, chef
}

class Account: Codable {
    private var id: String
    private var password: String
    private var accountStatus: AccountStatus
    private var userRole: UserRole
    
    init(id: String, password: String, accountStatus: AccountStatus, userRole: UserRole) {
        self.id = id
        self.password = password
        self.accountStatus = accountStatus
        self.userRole = userRole
    }
    
    func getId() -> String {
        return id
    }
    
    func getPassword() -> String {
        return password
    }
    
    func verifyPassword(_ password: String) -> Bool {
        return self.password == password
    }
    
    func updateUsername(_ username: String) {
        self.id = username
    }
    
    func updatePassword(_ password: String) {
        self.password = password
    }
    
    // TODO: Add a hashed password and then compare the hashed input password with the stored hashed password(CryptoKit)
}

extension Account: Equatable {
    static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.id == rhs.id
    }
}

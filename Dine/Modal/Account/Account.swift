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
    case admin, manager, waitStaff, chef
}

class Account: Codable {
    private let userId: UUID
    private var username: String
    private var password: String
    private var accountStatus: AccountStatus
    private var userRole: UserRole
    
    init(username: String, password: String, accountStatus: AccountStatus, userRole: UserRole) {
        self.userId = UUID()
        self.username = username
        self.password = password
        self.accountStatus = accountStatus
        self.userRole = userRole
    }
    
    func getUserId() -> UUID {
        return userId
    }
    
    func getUsername() -> String {
        return username
    }
    
    func getPassword() -> String {
        return password
    }
    
    func verifyPassword(_ password: String) -> Bool {
        return self.password == password
    }
    
    func updateUsername(_ username: String) {
        self.username = username
    }
    
    func updatePassword(_ password: String) {
        self.password = password
    }
    
    // TODO: Add a hashed password and then compare the hashed input password with the stored hashed password(CryptoKit)
}

extension Account: Equatable {
    static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.username == rhs.username
    }
}

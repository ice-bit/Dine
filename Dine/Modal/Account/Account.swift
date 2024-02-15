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
    case admin, manager, waitStaff, chef, employee
}

class Account: Codable {
    private let _userId: UUID
    private var _username: String
    private var _password: String
    private var _accountStatus: AccountStatus
    private var _userRole: UserRole
    
    var username: String {
        return _username
    }
    
    var accountStatus: AccountStatus {
        return _accountStatus
    }
    
    var userRole: UserRole {
        return _userRole
    }
    
    var password: String {
        return _password
    }
    
    var userId: UUID {
        return _userId
    }
    
    init(username: String, password: String, accountStatus: AccountStatus, userRole: UserRole) {
        self._userId = UUID()
        self._username = username
        self._password = password
        self._accountStatus = accountStatus
        self._userRole = userRole
    }
    
    func verifyPassword(_ password: String) -> Bool {
        return self._password == password
    }
    
    func updateUsername(_ username: String) {
        self._username = username
    }
    
    func updatePassword(_ password: String) {
        self._password = password
    }
    
    // TODO: Add a hashed password and then compare the hashed input password with the stored hashed password(CryptoKit)
}

extension Account: Equatable {
    static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs._username == rhs._username
    }
}

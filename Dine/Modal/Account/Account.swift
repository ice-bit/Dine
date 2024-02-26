//
//  Account.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

enum AccountStatus: String {
    case active, closed, cancelled
}

enum UserRole: String, CaseIterable {
    case admin, manager, waitStaff, chef, employee
}

class Account {
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
    
    var description: String {
        return """
            User ID: \(_userId)
            Username: \(_username)
            Account Status: \(_accountStatus)
            User Role: \(_userRole)\n\n
            """
    }
    
    init(userId: UUID, username: String, password: String, accountStatus: AccountStatus, userRole: UserRole) {
        self._userId = userId
        self._username = username
        self._password = password
        self._accountStatus = accountStatus
        self._userRole = userRole
    }
    
    convenience init(username: String, password: String, accountStatus: AccountStatus, userRole: UserRole) {
        self.init(userId: UUID(), username: username, password: password, accountStatus: accountStatus, userRole: userRole)
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

extension Account: CSVWritable {
    func toCSVString() -> String {
        let csvText = "\(userId),\(username),\(password),\(accountStatus.rawValue),\(userRole.rawValue)"
        return csvText
    }
}

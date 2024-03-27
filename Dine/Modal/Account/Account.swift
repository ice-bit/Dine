//
//  Account.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation
import SQLite3

enum AccountStatus: String, Codable {
    case active, closed, cancelled
}

enum UserRole: String, CaseIterable, Codable {
    case admin, manager, waitStaff, kitchenStaff, employee
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

extension Account: SQLTable {
    static var createStatement: String {
        """
        CREATE TABLE IF NOT EXISTS \(DatabaseTables.accountTable.rawValue) (
            UserID VARCHAR(32) PRIMARY KEY,
            Username VARCHAR(255) UNIQUE NOT NULL,
            Password VARCHAR(255) NOT NULL,
            AccountStatus VARCHAR(20) NOT NULL,
            UserRole VARCHAR(20) NOT NULL
        );
        """
    }
}

extension Account: SQLUpdatable {
    // Warning: Never store passwords in plain text
    var createUpdateStatement: String {
        """
        UPDATE \(DatabaseTables.accountTable.rawValue)
            SET Username = '\(username)',
            Password = '\(password)',
            AccountStatus = '\(accountStatus.rawValue)',
            UserRole = '\(userRole.rawValue)'
        WHERE UserID = '\(userId.uuidString)';
        """
    }
}

extension Account: SQLInsertable {
    var createInsertStatement: String {
        """
        INSERT INTO \(DatabaseTables.accountTable.rawValue) (UserID, Username, Password, AccountStatus, UserRole)
        VALUES ('\(userId.uuidString)', '\(username)', '\(password)', '\(accountStatus.rawValue)', '\(userRole.rawValue)');
        """
    }
}

extension Account: SQLQueriable {
    static var createQueryStatement: String {
        """
        SELECT * FROM \(DatabaseTables.accountTable.rawValue);
        """
    }
}

extension Account: SQLDeletable {
    var createDeleteStatement: String {
        "DELETE FROM \(DatabaseTables.accountTable.rawValue) WHERE UserID = '\(userId)';"
    }
}

extension Account: DatabaseParsable {
    static func parseRow(statement: OpaquePointer?) throws -> Account? {
        guard let statement = statement else { return nil }
        
        guard let userIdCString = sqlite3_column_text(statement, 0),
              let usernameCString = sqlite3_column_text(statement, 1),
              let passwordCString = sqlite3_column_text(statement, 2),
              let accountStatusRawValueCString = sqlite3_column_text(statement, 3),
              let userRoleRawValueCString = sqlite3_column_text(statement, 4) else {
            throw DatabaseError.missingRequiredValue
        }
        
        guard let userId = UUID(uuidString: String(cString: userIdCString)),
              let accountStatus = AccountStatus(rawValue: String(cString: accountStatusRawValueCString)),
              let userRole = UserRole(rawValue: String(cString: userRoleRawValueCString)) else {
            throw DatabaseError.conversionFailed
        }
        
        let username = String(cString: usernameCString)
        let password = String(cString: passwordCString)
        
        return Account(userId: userId, username: username, password: password, accountStatus: accountStatus, userRole: userRole)
    }
}

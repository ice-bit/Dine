//
//  SQLiteDatabase.swift
//  Dine
//
//  Created by doss-zstch1212 on 14/03/24.
//

import Foundation
import SQLite3

protocol SQLTable {
    static var createStatement: String { get }
}

protocol SQLInsertable {
    var createInsertStatement: String { get }
}

protocol SQLQueriable {
    static var createQueryStatement: String { get }
}

protocol SQLDeletable {
    var createDeleteStatement: String { get }
}

protocol SQLUpdatable {
    var createUpdateStatement: String { get }
}

class SQLiteDatabase {
    private let dbPointer: OpaquePointer?
    
    init(dbPointer: OpaquePointer?) {
        self.dbPointer = dbPointer
    }
    
    deinit {
        sqlite3_close(dbPointer)
    }
    
    private var errorMessage: String {
        if let errorPointer = sqlite3_errmsg(dbPointer) {
            let errorMessage = String(cString: errorPointer)
            return errorMessage
        } else {
            return "No error message provided from SQLite3"
        }
    }
    
    static func open(path: String) throws -> SQLiteDatabase {
        var db: OpaquePointer?
        if sqlite3_open(path, &db) == SQLITE_OK {
            return SQLiteDatabase(dbPointer: db)
        } else {
            defer {
                if db != nil {
                    sqlite3_close(db)
                }
            }
            if let errorPointer = sqlite3_errmsg(db) {
                let message = String(cString: errorPointer)
                throw SQLiteError.openDatabase(message: message)
            } else {
                throw SQLiteError.openDatabase(message: "No error message provided from sqlite.")
            }
        }
    }
    
    func createTable(table: SQLTable.Type) throws {
        let createTableStatment = try prepareStatement(sql: table.createStatement)
        defer {
            sqlite3_finalize(createTableStatment)
        }
        guard sqlite3_step(createTableStatment) == SQLITE_DONE else {
            throw SQLiteError.step(message: errorMessage)
        }
        print("\(table) table created.")
    }
    
    func prepareStatement(sql: String) throws -> OpaquePointer? {
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(dbPointer, sql, -1, &statement, nil) == SQLITE_OK else {
            throw SQLiteError.prepare(message: errorMessage)
        }
        
        return statement
    }
    
    func insert(_ entity: SQLInsertable) throws {
        let insertStatement = try prepareStatement(sql: entity.createInsertStatement)
        defer {
            sqlite3_finalize(insertStatement)
        }
        // Skip binding because SQLInsertable provides sql statement with proper values
        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            throw SQLiteError.step(message: errorMessage)
        }
        print("Successfully inserted row.")
    }
    
    func retrieve(query: String, parseRow: (OpaquePointer?) throws -> Any?) throws -> [Any?] {
        let retrieveStatement = try prepareStatement(sql: query)
        defer {
            sqlite3_finalize(retrieveStatement)
        }
        var results: [Any?] = []
        while sqlite3_step(retrieveStatement) == SQLITE_ROW {
            let rowData = try parseRow(retrieveStatement)
            results.append(rowData)
        }
        return results
    }
    
    func delete(item: SQLDeletable) throws {
        let deleteStatement = try prepareStatement(sql: item.createDeleteStatement)
        defer {
            sqlite3_finalize(deleteStatement)
        }
        guard sqlite3_step(deleteStatement) == SQLITE_DONE else {
            throw SQLiteError.step(message: errorMessage)
        }
        print("Successfully delete row.")
    }
    
    func delete(from tableName: String, where condition: String? = nil) throws {
        var query = "DELETE FROM \(tableName) "
        if let condition = condition {
            query += "WHERE \(condition)"
        }
        query += ";"
        let deleteStatment = try prepareStatement(sql: query)
        guard sqlite3_step(deleteStatment) == SQLITE_DONE else {
            throw SQLiteError.step(message: errorMessage)
        }
    }
    
    func update(tableName: String, columnValuePairs: [String: Any], condition: String? = nil) throws {
        var query = "UPDATE \(tableName) SET "
        // Construct the SET clause with column-value pairs
        let setClause = columnValuePairs.map { "\($0.key) = \($0.value)"}.joined(separator: ", ")
        query += setClause
        // Add the WHERE clause if condition is provided
        if let condition = condition {
            query += " WHERE \(condition)"
        }
        query += ";"
        // Add semicolon to the end of the query
        let queryStatement = try prepareStatement(sql: query)
        defer {
            sqlite3_finalize(queryStatement)
        }
        guard sqlite3_step(queryStatement) == SQLITE_DONE else {
            throw SQLiteError.step(message: errorMessage)
        }
        print("Data updated successfully for table: \(tableName)")
    }
    
    func update(_ entity: SQLUpdatable) throws {
        let updateStatement = try prepareStatement(sql: entity.createUpdateStatement)
        defer {
            sqlite3_finalize(updateStatement)
        }
        guard sqlite3_step(updateStatement) == SQLITE_DONE else {
            throw SQLiteError.step(message: errorMessage)
        }
        print("Data updated successfully.")
//        weak var accountConView: AccountConsoleView? = AccountConsoleView()
    }

    func verifyTablesExistence(tableNames: [String]) throws -> Bool {
        for tableName in tableNames {
            let query = "SELECT COUNT(*) FROM sqlite_master WHERE type='table' AND name='\(tableName)';"
            let queryStatement = try prepareStatement(sql: query)
            defer {
                sqlite3_finalize(queryStatement)
            }
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let count = sqlite3_column_int(queryStatement, 0)
                
                // If count is greater than 0, the table exists
                if count > 0 {
                    print("Table \(tableName) exists")
                } else {
                    print("Table \(tableName) does not exist")
                    return false
                }
            }
        }
        return true
    }
}

// Example parserRow
/*func parseRow(statement: OpaquePointer?) throws -> [String] {
    guard let statement = statement else { return [] }
    var rowData: [String] = []
    for i in 0..<sqlite3_column_count(statement) {
        let value = String(cString: sqlite3_column_text(statement, i)!)
        rowData.append(value)
    }
    return rowData
}*/


/*func query(_ entity: SQLQueriable.Type) throws {
    let queryStatement = try prepareStatement(sql: entity.createQueryStatement)
    defer {
        sqlite3_finalize(queryStatement)
    }
    while (sqlite3_step(queryStatement) == SQLITE_ROW) {
        let user_id = sqlite3_column_int(queryStatement, 0)
        guard let queryResultCol1 = sqlite3_column_text(queryStatement, 1),
              let queryResultCol2 = sqlite3_column_text(queryStatement, 2),
              let queryResultCol3 = sqlite3_column_text(queryStatement, 3),
              let queryResultCol4 = sqlite3_column_text(queryStatement, 4) else {
            print("Query result is nil.")
            return
        }
        
        let username = String(cString: queryResultCol1)
        let password = String(cString: queryResultCol2)
        guard let accountStatus = AccountStatus(rawValue: String(cString: queryResultCol3)),
              let userRole = UserRole(rawValue: String(cString: queryResultCol4)) else {
            print("Enums are nil")
            return
        }
        print("Id: \(user_id)")
        let account = Account(userId: UUID(), username: username, password: password, accountStatus: accountStatus, userRole: userRole)
        print(account.description)
    }
}*/

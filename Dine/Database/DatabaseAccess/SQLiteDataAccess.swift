//
//  SQLiteDataAccess.swift
//  Dine
//
//  Created by doss-zstch1212 on 15/03/24.
//

import Foundation

protocol DatabaseAccess {
    func createTable(for entity: SQLTable.Type) throws
    func insert(_ entity: SQLInsertable) throws
    func retrieve(query: String, parseRow: (OpaquePointer?) throws -> Any?) throws -> [Any?]
    func update(tableName: String, columnValuePairs: [String: Any], condition: String?) throws
    func update(_ entity: SQLUpdatable) throws
    func delete(item: SQLDeletable) throws
    func delete(from tableName: String, where condition: String?) throws
    func verifyTablesExistence(tableNames: [String]) throws -> Bool
}

class SQLiteDataAccess: DatabaseAccess {
    private let database: SQLiteDatabase
    
    init(database: SQLiteDatabase) {
        self.database = database
    }
    
    static func openDatabase() throws -> SQLiteDataAccess {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw FileIOError.documentDirectoryUnavailable
        }
        let fileURL = documentDirectory.appending(path: "dine.sqlite")
        let database = try SQLiteDatabase.open(path: fileURL.absoluteString)
        return SQLiteDataAccess(database: database)
    }
    
    func createTable(for entity: SQLTable.Type) throws {
        try database.createTable(table: entity)
    }
    
    func insert(_ entity: SQLInsertable) throws {
        try database.insert(entity)
    }
    
    func retrieve(query: String, parseRow: (OpaquePointer?) throws -> Any?) throws -> [Any?] {
        try database.retrieve(query: query, parseRow: parseRow)
    }
    
    func delete(item: SQLDeletable) throws {
        try database.delete(item: item)
    }
    
    func delete(from tableName: String, where condition: String? = nil) throws {
        try database.delete(from: tableName, where: condition)
    }
    
    func update(tableName: String, columnValuePairs: [String: Any], condition: String?) throws {
        try database.update(tableName: tableName, columnValuePairs: columnValuePairs, condition: condition)
    }
    
    func update(_ entity: SQLUpdatable) throws {
        try database.update(entity)
    }
    
    func verifyTablesExistence(tableNames: [String]) throws -> Bool {
        try database.verifyTablesExistence(tableNames: tableNames)
    }
}



//
//  DatabaseService.swift
//  Dine
//
//  Created by doss-zstch1212 on 27/03/24.
//

import Foundation
import SQLite3

struct DatabaseService {
    private let databaseAccess: DatabaseAccess
    init(databaseAccess: DatabaseAccess) {
        self.databaseAccess = databaseAccess
    }
    func verifyTablesExistence() -> Bool {
        var tableNames = [String]()
        for tableName in DatabaseTables.allCases {
            tableNames.append(tableName.rawValue)
        }
        do {
            return try databaseAccess.verifyTablesExistence(tableNames: tableNames)
        } catch {
            print(error)
        }
        return false
    }
    
    func verifyAdminExistence() -> Bool {
        let query = "SELECT * FROM \(DatabaseTables.accountTable.rawValue) WHERE Username = 'admin';"
        guard (try? databaseAccess.retrieve(query: query, parseRow: Account.parseRow).first as? Account) != nil else {
            print("No admin found.")
            return false
        }
        return true
    }
    
    func verifyRestaurantExistence() -> Bool {
        let query = "SELECT * FROM \(DatabaseTables.restaurantDBTable.rawValue);"
        guard (try? databaseAccess.retrieve(query: query, parseRow: Restaurant.parseRow) as? [Restaurant]) != nil else {
            print("No restataurnt found")
            return false
        }
        return true
    }
}

//
//  AccountService.swift
//  Dine
//
//  Created by doss-zstch1212 on 27/03/24.
//

import Foundation

protocol AccountService {
    func add(_ account: Account) throws
    func fetch() throws -> [Account]?
    func update(_ account: Account) throws
    func delete(_ account: Account) throws
}

struct AccountServiceImpl: AccountService {
    private let databaseAccess: DatabaseAccess
    init(databaseAccess: DatabaseAccess) {
        self.databaseAccess = databaseAccess
    }
   
    func add(_ account: Account) throws {
        try databaseAccess.insert(account)
    }
    
    func fetch() throws -> [Account]? {
        let query = "SELECT * FROM \(DatabaseTables.accountTable.rawValue);"
        guard let results = try? databaseAccess.retrieve(query: query, parseRow: Account.parseRow) as? [Account] else {
            print("Failed to load accounts")
            return nil
        }
        return results
    }
    
    func update(_ account: Account) throws {
        try databaseAccess.update(account)
    }
    
    func delete(_ account: Account) throws {
        try databaseAccess.delete(item: account)
    }
}

//
//  BillService.swift
//  Dine
//
//  Created by doss-zstch1212 on 26/03/24.
//

import Foundation

protocol BillService {
    func add(_ bill: Bill) throws
    func fetch() throws -> [Bill]?
    func update(_ bill: Bill) throws
    func delete(_ bill: Bill) throws
}

struct BillServiceImpl: BillService {
    func add(_ bill: Bill) throws {
        try databaseAccess.insert(bill)
    }
    
    func fetch() throws -> [Bill]? {
        let query = "SELECT * FROM \(DatabaseTables.billTable.rawValue);"
        guard let resultBills = try? databaseAccess.retrieve(query: query, parseRow: Bill.parseRow) as? [Bill] else {
            throw DatabaseError.conversionFailed
        }
        return resultBills
    }
    
    func update(_ bill: Bill) throws {
        try databaseAccess.update(bill)
    }
    
    func delete(_ bill: Bill) throws {
        try databaseAccess.delete(item: bill)
    }
    
    private let databaseAccess: DatabaseAccess
    init(databaseAccess: DatabaseAccess) {
        self.databaseAccess = databaseAccess
    }
    
}

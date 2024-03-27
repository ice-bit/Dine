//
//  TableService.swift
//  Dine
//
//  Created by doss-zstch1212 on 26/03/24.
//

import Foundation

protocol TableService {
    func add(_ table: RestaurantTable) throws
    func fetch() throws -> [RestaurantTable]?
    func update(_ table: RestaurantTable) throws
    func delete(_ table: RestaurantTable) throws
}

protocol TableStatusDelegate {
    func tableStatusDidChange(to status: TableStatus)
}

struct TableServiceImpl: TableService {
    private let databaseAccess: DatabaseAccess
    init(databaseAccess: DatabaseAccess) {
        self.databaseAccess = databaseAccess
    }
    
    func add(_ table: RestaurantTable) throws {
        try databaseAccess.insert(table)
    }
    
    func fetch() throws -> [RestaurantTable]? {
        let query = "SELECT * FROM \(DatabaseTables.restaurantTable.rawValue);"
        let resultTables = try databaseAccess.retrieve(query: query, parseRow: RestaurantTable.parseRow) as? [RestaurantTable]
        return resultTables
    }
    
    func update(_ table: RestaurantTable) throws {
        try databaseAccess.update(table)
    }
    
    func delete(_ table: RestaurantTable) throws {
        try databaseAccess.delete(item: table)
    }
}


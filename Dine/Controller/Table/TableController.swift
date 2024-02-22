//
//  TableController.swift
//  Dine
//
//  Created by doss-zstch1212 on 12/02/24.
//

import Foundation

protocol TableService {
    func addTable(maxCapacity: Int, locationIdentifier: Int)
    func removeTable(_ table: Table)
    func fetchAvailableTables() -> [Table]
    func fetchTables() -> [Table]
}

class TableController: TableService {
    private let tableManager = TableManager.shared

    func addTable(maxCapacity: Int, locationIdentifier: Int) {
        let table = Table(maxCapacity: maxCapacity, locationIdentifier: locationIdentifier)
        tableManager.addTable(table)
    }
    
    func removeTable(_ table: Table)  {
        // Check if table is available or not...
        tableManager.removeTable(table)
    }
    
    func fetchAvailableTables() -> [Table] {
        tableManager.availableTables
    }
    
    func fetchTables() -> [Table] {
        tableManager.getTables
    }
}

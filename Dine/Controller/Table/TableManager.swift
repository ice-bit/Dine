//
//  TableManager.swift
//  Dine
//
//  Created by doss-zstch1212 on 30/01/24.
//

import Foundation

class TableManager: Codable {
    static let shared = TableManager()
    
    private init() {}
    
    private var tables: [Table] = []
    
    var getTables: [Table] {
        return tables
    }
    
    var tablesCount: Int {
        return tables.count
    }
    
    var availableTables: [Table] {
        return tables.filter { $0.tableStatus == .free }
    }
    
    func addTable(_ table: Table) {
        tables.append(table)
    }
    
    func removeTable(_ table: Table) {
        if let index = tables.firstIndex(where: {$0.tableId == table.tableId }) {
            tables.remove(at: index)
        } else {
            print("No tables found")
        }
    }
}

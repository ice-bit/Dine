//
//  TableManager.swift
//  Dine
//
//  Created by doss-zstch1212 on 30/01/24.
//

import Foundation

class TableManager {
    static let shared = TableManager()
    
    private init() {
        loadTables()
    }
    
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
        saveTables()
    }
    
    func removeTable(_ table: Table) {
        if let index = tables.firstIndex(where: {$0.tableId == table.tableId }) {
            tables.remove(at: index)
            saveTables()
        } else {
            print("No tables found")
        }
    }
    
    func saveTables() {
        Task {
            let csvDAO = CSVDataAccessObject()
            await csvDAO.save(to: .tableFile, entity: self)
        }
    }
    
    func loadTables() {
        Task {
            let csvDAO = CSVDataAccessObject()
            if let tables = await csvDAO.load(from: .tableFile, parser: TableParser()) as? [Table] {
                self.tables = tables
            }
        }
    }
    
}

extension TableManager: CSVWritable {
    func toCSVString() -> String {
        var csvString = "tableId,tableStatus,maxCapacity,locationIdentifier"
        
        for (index, table) in tables.enumerated() {
            let row = table.getCSVString()
            
            // Append a new line if it's not the last account
            if index != self.tables.count {
                csvString.append("\n")
            }
            
            csvString.append(row)
        }
        
        return csvString
    }
}

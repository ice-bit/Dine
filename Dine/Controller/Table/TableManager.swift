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
        retrieveTable()
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
        saveTable()
    }
    
    func removeTable(_ table: Table) {
        if let index = tables.firstIndex(where: {$0.tableId == table.tableId }) {
            tables.remove(at: index)
            saveTable()
        } else {
            print("No tables found")
        }
    }
    
    func retrieveTable() {
        let csvReader = CSVReader()
        let csvParser = CSVParser()
        
        do {
            let data = try csvReader.readCSV(from: FileName.table.rawValue)
            tables = csvParser.parseTables(from: data)
        } catch {
            print("Error: \(error)")
        }
    }
    
    func saveTable() {
        let csvWriter = CSVWriter(fileName: FileName.table.rawValue)
        do {
            if try csvWriter.writeToCSV(csvDataModal: self) {
                print("Write success")
            }
        } catch {
            print("Error: \(error)")
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

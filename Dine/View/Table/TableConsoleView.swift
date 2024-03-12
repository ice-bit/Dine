//
//  TableConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 12/02/24.
//

import Foundation

class TableConsoleView {
    private let tableService: TableService = TableController()
    
    func displayOptions() {
        print("Table Customization Menu")
        print("1. Add Table")
        print("2. Remove Table")
        print("0. Go Back")
        handleTableOptions()
    }
    
    func viewTables() {
        let tables = tableService.fetchTables()
        for (index, table) in tables.enumerated() {
            print("\(index + 1) - Table: \(table.tableId)\n - Location ID:\(table.locationId)\n - Status: \(table.tableStatus)")
        }
    }
    
    private func handleTableOptions() {
        print("Enter your choice:")
        let choice = readLine() ?? ""
        switch choice {
        case "1":
            addTablePrompt()
        case "2":
            removeTablePrompt()
        case "0":
            return
        default:
            print("Invalid input")
            handleTableOptions()
        }
    }
    
    private func addTablePrompt() {
        print("Enter table capacity:")
        guard let capacityStr = readLine(), let capacity = Int(capacityStr) else {
            print("Invalid input for table capacity")
            return
        }
        
        print("Enter location identifier:")
        guard let locationIdStr = readLine(), let locationId = Int(locationIdStr) else {
            print("Invalid input for location identifier")
            return
        }
    
        tableService.addTable(maxCapacity: capacity, locationIdentifier: locationId)
    }
    
    private func removeTablePrompt() {
        let availableTables = tableService.fetchAvailableTables()
        
        guard !availableTables.isEmpty else {
            print("No tables available.")
            return
        }
        
        print("Available Tables:")
        for (index, table) in availableTables.enumerated() {
            print("\(index + 1). Table \(table.tableId) - Status: \(table.tableStatus)")
        }
        
        print("Enter the number of the table you want to remove (or 0 to cancel):")
        if let choice = readLine(), let tableNumber = Int(choice), tableNumber >= 1, tableNumber <= availableTables.count {
            let chosenTable = availableTables[tableNumber - 1]
            print("You chose Table \(chosenTable.tableId)")
            let tables = tableService.fetchTables()
            guard let table = tables.first(where: { $0.tableId == chosenTable.tableId }) else { return }
            
            tableService.removeTable(table)
        } else {
            print("Invalid choice or canceled.")
            return
        }
    }

}

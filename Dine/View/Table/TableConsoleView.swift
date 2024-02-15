//
//  TableConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 12/02/24.
//

import Foundation

class TableConsoleView {
    private let tableManager: TableManager
    
    init(tableManager: TableManager) {
        self.tableManager = tableManager
    }
    
    func displayOptions() {
        print("Table Customization Menu")
        print("1. Add Table")
        print("2. Remove Table")
        print("0. Go Back")
        handleTableOptions()
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
        
        let tableController = TableController(tableManager: tableManager)
        tableController.addTable(maxCapacity: capacity, locationIdentifier: locationId)
    }
    
    private func removeTablePrompt() {
        let availableTables = tableManager.availableTables
        
        guard !availableTables.isEmpty else {
            print("No tables available.")
            return
        }
        
        print("Available Tables:")
        for (index, table) in availableTables.enumerated() {
            print("\(index + 1). Table \(table.tableId) - Status: \(table.tableStatus)")
        }
        
        print("Enter the number of the table you want to remove (or 0 to cancel):")
        if let choice = readLine(), let tableNumber = Int(choice), tableNumber >= 1, tableNumber <= tableManager.availableTables.count {
            let chosenTable = tableManager.availableTables[tableNumber - 1]
            print("You chose Table \(chosenTable.tableId)")
            guard let table = tableManager.getTables.first(where: { $0.tableId == chosenTable.tableId }) else { return }
            
            let tableController = TableController(tableManager: tableManager)
            tableController.removeTable(table)
        } else {
            print("Invalid choice or canceled.")
            return
        }
    }

}

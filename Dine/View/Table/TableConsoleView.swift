//
//  TableConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 12/02/24.
//

import Foundation

class TableConsoleView {
    private let tableController: TableServicable
    init(tableService: TableServicable) {
        self.tableController = tableService
    }
    
    func displayOptions() {
        print("Table Customization Menu")
        print("1. Add Table")
        print("2. Remove Table")
        print("0. Go Back")
        handleTableOptions()
    }
    
    func viewTables() {
        guard let tables = tableController.fetchTables() else {
            print("No tables available")
            return
        }
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
        if tableController.addTable(maxCapacity: capacity, locationIdentifier: locationId) {
            print("Table added successfully.")
        }
    }
    
    private func removeTablePrompt() {
        guard let availableTables = tableController.fetchAvailableTables() else {
            print("No tables available")
            return
        }

        guard !availableTables.isEmpty else {
            print("No available tables")
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
            guard let tables = tableController.fetchTables() else {
                print("No tables available")
                return
            }
            guard let table = tables.first(where: { $0.tableId == chosenTable.tableId }) else { return }
            if tableController.removeTable(table) {
                print("Table removed Successfully")
            }
        } else {
            print("Invalid choice or canceled.")
            return
        }
    }

}

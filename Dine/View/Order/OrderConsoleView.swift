//
//  OrderConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 25/01/24.
//

import Foundation

class OrderConsoleView {
    private let branch: Branch
    private let orderManager: OrderManager
    private let tableManager: TableManager
    
    init(branch: Branch, orderManager: OrderManager, tableManager: TableManager) {
        self.branch = branch
        self.orderManager = orderManager
        self.tableManager = tableManager
    }
    
    func displayMenu() {
//        menu.displayMenu()
        takeOrder()
        
    }
    
    func displayTablesAndChoose() -> Table? {
        let availableTables = branch.availableTables
        
        guard !availableTables.isEmpty else {
            print("No tables available.")
            return nil
        }
        
        print("Available Tables:")
        for (index, table) in availableTables.enumerated() {
            print("\(index + 1). Table \(table.tableId) - Status: \(table.tableStatus)")
        }
        
        print("Enter the number of the table you want to choose (or 0 to cancel):")
        if let choice = readLine(), let tableNumber = Int(choice), tableNumber >= 1, tableNumber <= branch.tablesCount {
            let chosenTable = branch.tables[tableNumber - 1]
            print("You chose Table \(chosenTable.tableId)")
            return chosenTable
        } else {
            print("Invalid choice or canceled.")
            return nil
        }
    }
    
    func takeOrder() {
        var orderItems: [MenuItem] = []
        
        // Display menu items
        branch.menu.displayMenuItems()
        
        while true {
            print("Enter the item number to add to your order (0 to finish):")
            
            if let input = readLine(), let choice = Int(input), choice >= 0 && choice <= branch.menu.itemsCount {
                if choice == 0 {
                    break
                } else {
                    let selectedItem = branch.menu[choice - 1]
                    orderItems.append(selectedItem)
                    print("Added \(selectedItem.name) to your order.")
                }
            } else {
                print("Invalid input. Please enter a valid item number.")
            }
        }
        
        // Below code snippet is for test purposes
        print("Your order:")
        for item in orderItems {
            print("\(item.name) - $\(item.price)")
        }
        print("Total: $\(orderItems.reduce(0.0) { $0 + $1.price })")
        
        guard !orderItems.isEmpty else { return }
        
        // Process order
        
        guard let table = displayTablesAndChoose() else {
            print("Table not found!")
            return
        }
        
        let orderController = OrderController(orderManager: orderManager)
        orderController.createOrder(for: table, menuItem: orderItems)
        print("Order created successfully!")
    }
    
    func viewOrders() {
        let orders = orderManager.orders
        
        for (index, order) in orders.enumerated() {
            print("\(index). Order: \(order.orderId)")
            print(" - Ordered Items:")
            print(" - \(order.displayOrderItems())")
        }
    }
}

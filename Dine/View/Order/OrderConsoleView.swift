//
//  OrderConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 25/01/24.
//

import Foundation

class OrderConsoleView {
    private let restaurant: Restaurant
    private let menuController: MenuController
    private let orderService: OrderServicable
    private let tableController: TableServicable
    init(restaurant: Restaurant, menuController: MenuController, orderService: OrderServicable, tableService: TableServicable) {
        self.restaurant = restaurant
        self.menuController = menuController
        self.orderService = orderService
        self.tableController = tableService
    }
    
    func displayTablesAndChoose() -> RestaurantTable? {
        guard let availableTables = tableController.fetchAvailableTables(),
              !availableTables.isEmpty else {
            print("No tables available or try adding new tables.")
            return nil
        }
        
        print("Available Tables:")
        for (index, table) in availableTables.enumerated() {
            print("\(index + 1). Table \(table.tableId) - Status: \(table.tableStatus)")
        }
        
        print("Enter the number of the table you want to choose (or 0 to cancel):")
        if let choice = readLine(), let tableNumber = Int(choice), tableNumber >= 1, tableNumber <= availableTables.count {
            let chosenTable = availableTables[tableNumber - 1]
            print("You chose Table \(chosenTable.tableId)")
            guard let tables: [RestaurantTable] = tableController.fetchTables() else {
                print("No tables available.")
                return nil
            }
            return tables.first(where: { $0.tableId == chosenTable.tableId })
            
        } else { 
            print("Invalid choice or canceled.")
            return nil
        }
    }
    
    func promptMenuItemsSelection() {
        var orderQuantities: [MenuItem: Int] = [:]
        guard let menuItems = menuController.getMenuItems() else {
            print("No items found!")
            return
        }
        // Display menu items
        for (index, item) in menuItems.enumerated() {
            print("\(index + 1). \(item.name) - $\(item.price)")
        }
        // TODO: Unneccessary
        guard let itemsCount = menuController.itemsCount(),
              itemsCount > 0 else {
            print("No MenuItems found!")
            return
        }
        
        
        while true {
            print("Enter the item number to add to your order (0 to finish):")
            
            if let input = readLine(), let choice = Int(input), choice >= 0 && choice <= itemsCount {
                if choice == 0 {
                    break
                } else {
                    let selectedItem = menuItems[choice - 1]
                    
                    // Update quantity or add new item to the order
                    if let quantity = orderQuantities[selectedItem] {
                        orderQuantities[selectedItem] = quantity + 1
                    } else {
                        orderQuantities[selectedItem] = 1
                    }
                    
                    print("Added \(selectedItem.name) to your order.")
                }
            } else {
                print("Invalid input. Please enter a valid item number.")
            }
        }
        
        // Print order summary
        print("Your order:")
        for (item, quantity) in orderQuantities {
            print("\(item.name) - \(quantity) x $\(item.price)")
        }
        let totalPrice = orderQuantities.reduce(0.0) { $0 + ($1.key.price * Double($1.value)) }
        print("Total: $\(totalPrice)")
        
        guard !orderQuantities.isEmpty else { return }
        
        // Process order
        guard let table = displayTablesAndChoose() else {
            print("Table not found!")
            return
        }
        
        do {
            try orderService.createOrder(for: table, menuItems: orderQuantities)
            print("Order created successfully!")
        } catch {
            print(error)
        }
    }
    
    func viewOrders() {
        guard let orderCount = orderService.getOrdersCount() else {
            print("No orders found")
            return
        }
        guard orderCount > 0 else {
            print("No orders recieved. Please place orders.")
            return
        }
        
        orderService.displayOrders()
    }
}

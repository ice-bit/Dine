//
//  OrderConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 25/01/24.
//

import Foundation

class OrderConsoleView {
    private let restaurant: Restaurant
    private let menu = Menu.shared
    private let orderService: OrderService = OrderController()
    private let tableService: TableService = TableController()
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        loadMenu()
    }
    
    func loadMenu() {
        Menu.shared.loadMenu()
    }
    
    func displayTablesAndChoose() -> Table? {
        let availableTables = tableService.fetchAvailableTables()
        
        guard !availableTables.isEmpty else {
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
            let tables: [Table] = tableService.fetchTables()
            return tables.first(where: { $0.tableId == chosenTable.tableId })
        } else {
            print("Invalid choice or canceled.")
            return nil
        }
    }
    
    func promptMenuItemsSelection() {
        var orderQuantities: [MenuItem: Int] = [:]
        
        // Display menu items
        menu.displayMenuItems()
        
        while true {
            print("Enter the item number to add to your order (0 to finish):")
            
            if let input = readLine(), let choice = Int(input), choice >= 0 && choice <= menu.itemsCount {
                if choice == 0 {
                    break
                } else {
                    let selectedItem = menu[choice - 1]
                    
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
        
        orderService.createOrder(for: table, menuItems: orderQuantities)
        print("Order created successfully!")
    }
    
    func viewOrders() {
        let orderCount: Int = orderService.getOrdersCount()
        guard orderCount > 0 else {
            print("No orders recieved. Please place orders.")
            return
        }
        
        orderService.displayOrders()
    }
}

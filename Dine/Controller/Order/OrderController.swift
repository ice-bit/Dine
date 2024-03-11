//
//  OrderController.swift
//  Dine
//
//  Created by doss-zstch1212 on 24/01/24.
//

import Foundation

protocol OrderService {
    func createOrder(for table: Table, menuItems: [MenuItem: Int])
    func getOrdersCount() -> Int
    func displayOrders()
    func getUnbilledOrders() -> [Order]?
}

class OrderController: OrderService {
    private let orderManager = OrderManager.shared
    
    func createOrder(for table: Table, menuItems: [MenuItem: Int]) {
        var orderMenuItems: [MenuItem] = []
        
        // Iterate through the dictionary of menu item quantities
        for (menuItem, quantity) in menuItems {
            // Append the menu item to the array the specified number of times
            orderMenuItems.append(contentsOf: Array(repeating: menuItem, count: quantity))
        }
        
        let order = Order(tableId: table.tableId, orderStatus: .received, menuItems: orderMenuItems)
        // Change table status
        TableManager.shared.changeTableStatus(for: table.tableId, to: .occupied)
        
        
        
        // Adding to OrderManager
        orderManager.addOrder(order: order)
    }
    
    func getOrdersCount() -> Int {
        orderManager.ordersCount
    }
    
    func displayOrders() {
        orderManager.displayOrders()
    }
    
    func getUnbilledOrders() -> [Order]? {
        return orderManager.getUnbilledOrders()
    }
}

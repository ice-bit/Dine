//
//  OrderController.swift
//  Dine
//
//  Created by doss-zstch1212 on 24/01/24.
//

import Foundation

class OrderController {
    private var orderManager: OrderManager
    
    init(orderManager: OrderManager) {
        self.orderManager = orderManager
    }
    
    func createOrder(for table: Table, menuItem: [MenuItem]) {
        let order = Order(table: table, orderStatus: .completed, menuItems: menuItem)
        // Change table status
        table.changeTableStatus(to: .occupied)
        
        // Adding to OrderManager
        orderManager.addOrder(order: order)
    }
    
    
}

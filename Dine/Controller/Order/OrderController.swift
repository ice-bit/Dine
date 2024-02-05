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
        let order = Order(table: table, orderStatus: .received, menuItems: menuItem)
        orderManager.addOrder(order: order)
        table.changeTableStatus(to: .occupied)
    }
    
    
}

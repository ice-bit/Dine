//
//  OrderController.swift
//  Dine
//
//  Created by doss-zstch1212 on 24/01/24.
//

import Foundation

protocol OrderService {
    func createOrder(for table: Table, menuItem: [MenuItem])
    func getOrdersCount() -> Int
    func displayOrders()
    func getUnbilledOrders() -> [Order]?
}

class OrderController: OrderService {
    private let orderManager = OrderManager.shared
    
    func createOrder(for table: Table, menuItem: [MenuItem]) {
        let order = Order(table: table, orderStatus: .received, menuItems: menuItem)
        // Change table status
        table.changeTableStatus(to: .occupied)
        
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

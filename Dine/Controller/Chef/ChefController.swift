//
//  ChefController.swift
//  Dine
//
//  Created by doss-zstch1212 on 31/01/24.
//

import Foundation

class ChefController {
    private let orderManager: OrderManager
    
    init(orderManager: OrderManager) {
        self.orderManager = orderManager
    }
    
    func changeStatus(for order: Order, to status: OrderStatus) {
        order.changeOrderStatus(status)
    }
    
    func fetchReceivedOrders() -> [Order]? {
        let receivedOrders = orderManager.getUncompletedOrders
        
        guard !receivedOrders.isEmpty else {
            print("No received orders found!")
            return nil
        }
        
        return receivedOrders
    }
}

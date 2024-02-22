//
//  ChefController.swift
//  Dine
//
//  Created by doss-zstch1212 on 31/01/24.
//

import Foundation

protocol UpdateStatusService {
    func changeStatus(for order: Order, to status: OrderStatus)
    func fetchReceivedOrders() -> [Order]?
}

class UpdateStatusController: UpdateStatusService {
    private let orderManager = OrderManager.shared
    
    func changeStatus(for order: Order, to status: OrderStatus) {
        order.changeOrderStatus(status)
    }
    
    func fetchReceivedOrders() -> [Order]? {
        let receivedOrders = orderManager.orders.filter({ $0.orderStatus == .received })
        
        guard !receivedOrders.isEmpty else {
            print("No received orders found!")
            return nil
        }
        
        return receivedOrders
    }
}

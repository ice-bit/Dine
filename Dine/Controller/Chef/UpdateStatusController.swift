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
    private let orderManager: OrderManager = OrderManager.shared
    
    func changeStatus(for order: Order, to status: OrderStatus) {
        order.changeOrderStatus(to: status)
    }
    
    func fetchReceivedOrders() -> [Order]? {
        let receivedOrders = orderManager.getUncompletedOrders()
        
        guard !receivedOrders.isEmpty else {
            print("No received orders found!")
            return nil
        }
        
        return receivedOrders
    }
}

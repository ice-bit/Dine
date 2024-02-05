//
//  OrderManager.swift
//  Dine
//
//  Created by doss-zstch1212 on 29/01/24.
//

import Foundation

class OrderManager: Codable {
    private var _orders: [Order] = []
    
    var orders: [Order] {
        return _orders
    }
    
    func addOrder( order: Order) {
        _orders.append(order)
        
    }
    
    func removeOrder(_ order: Order) -> Bool {
        guard let orderIndex = _orders.firstIndex(where: { $0.orderId == order.orderId }) else {
            return false
        }
        
        _orders.remove(at: orderIndex)
        
        return true
    }
    
    // Orders that are completed
    func getUnbilledOrders() -> [Order]? {
        let unbilledOrders = _orders.filter { $0.orderStatus == .received }
        
        guard !unbilledOrders.isEmpty else { return nil }
        
        return unbilledOrders
    }
}

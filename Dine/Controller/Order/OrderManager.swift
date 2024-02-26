//
//  OrderManager.swift
//  Dine
//
//  Created by doss-zstch1212 on 29/01/24.
//

import Foundation

class OrderManager {
    static let shared = OrderManager()
    
    private init() {}
    
    private var _orders: [Order] = []
    
    var ordersCount: Int {
        return _orders.count
    }
    
    var getUncompletedOrders: [Order] {
        _orders.filter({ $0.orderStatus == .received || $0.orderStatus == .preparing })
    }
    
    subscript(_ index: Int) -> Order {
        return _orders[index]
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
        let unbilledOrders = _orders.filter { $0.isOrderBilled == false && $0.orderStatus == .completed }
        
        guard !unbilledOrders.isEmpty else { return nil }
        
        return unbilledOrders
    }
    
    func displayOrders() {
        for (index, order) in _orders.enumerated() {
            print("\(index + 1). Order: \(order.orderId)")
            print(" - Ordered Items:")
            print(" - \(order.displayOrderItems())")
        }
    }
}

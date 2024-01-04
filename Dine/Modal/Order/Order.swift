//
//  Order.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

enum OrderStatus: Int {
    case received = 1
    case preparing = 2
    case completed = 3
    case cancelled = 4
    case none = 5
}

class Order {
    private var orderId: Int
    private var orderDate = Date()
    private var orderStatus: OrderStatus
    private var meals: [Meal]
    private var chef: Chef
    private var waiter: WaitStaff
    
    init(orderId: Int, orderDate: Date = Date(), orderStatus: OrderStatus, meals: [Meal], chef: Chef, waiter: WaitStaff) {
        self.orderId = orderId
        self.orderDate = orderDate
        self.orderStatus = orderStatus
        self.meals = meals
        self.chef = chef
        self.waiter = waiter
    }
    
    func addMeal() {
        
    }
    
    func removeMeal() {
        
    }
    
    func getStatus() -> OrderStatus {
        // Example usage
        return orderStatus
    }
    
    func setStatus(to status: OrderStatus) {
        self.orderStatus = status
    }
}

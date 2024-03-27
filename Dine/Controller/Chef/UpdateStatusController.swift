//
//  ChefController.swift
//  Dine
//
//  Created by doss-zstch1212 on 31/01/24.
//

import Foundation

protocol UpdateStatusService {
    func changeStatus(for order: Order, to status: OrderStatus) throws
    func fetchReceivedOrders() -> [Order]?
}

class UpdateStatusController: UpdateStatusService {
    private let orderService: OrderService
    init(orderService: OrderService) {
        self.orderService = orderService
    }
    func changeStatus(for order: Order, to status: OrderStatus) throws {
        order.orderStatusValue = status
        try orderService.update(order)
//        let table =
        if status == .completed {
//            try orderService.
        }
        try orderService.update(order)
    }
    
    func fetchReceivedOrders() -> [Order]? {
        do {
            let resultOrders = try orderService.fetch()
            return resultOrders
        } catch {
            print("Failed to fetch orders: \(error)")
        }
        
        return nil
        
    }
}

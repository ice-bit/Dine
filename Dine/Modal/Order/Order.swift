//
//  Order.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

enum OrderStatus: Int, Codable, CaseIterable {
    case received = 1
    case preparing = 2
    case completed = 3
    case cancelled = 4
    case none = 5
}

class Order: Codable {
    private let _orderId: UUID
    private let table: Table
    private var _orderStatus: OrderStatus
    private let menuItems: [MenuItem]
    
    var orderStatus: OrderStatus {
        return _orderStatus
    }
    
    var tableLocationId: Int {
        return table.getTableLocationId()
    }
    
    var orderId: UUID {
        return _orderId
    }
    
    init(table: Table, orderStatus: OrderStatus, menuItems: [MenuItem]) {
        self._orderId = UUID()
        self.table = table
        self._orderStatus = orderStatus
        self.menuItems = menuItems
    }
    
    func displayOrderItems() {
        for (index, item) in menuItems.enumerated() {
            print("\(index + 1). \(item.name) - $\(item.price)")
        }
    }
    
    func orderedItems() -> [MenuItem] {
        return menuItems
    }
    
    func changeOrderStatus(_ status: OrderStatus) {
        _orderStatus = status
    }
}



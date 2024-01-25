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

class Check {
    
}

class Order {
    
    private let table: Table
    private let orderStatus: OrderStatus
    private let menuItems: [MenuItem]
    
    convenience init(table: Table, orderStatus: OrderStatus) {
        self.init(table: table, orderStatus: orderStatus, menuItems: [])
    }
    
    init(table: Table, orderStatus: OrderStatus, menuItems: [MenuItem]) {
        self.table = table
        self.orderStatus = orderStatus
        self.menuItems = menuItems
    }
    
}

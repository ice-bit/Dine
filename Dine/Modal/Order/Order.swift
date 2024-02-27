//
//  Order.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

enum OrderStatus: String, CaseIterable {
    case received
    case preparing
    case completed
    case cancelled
    case none
}

class Order {
    private let _orderId: UUID
    private let tableId: UUID
    private var _orderStatus: OrderStatus {
        didSet {
            if _orderStatus == .completed {
//                table.changeTableStatus(to: .free)  // write a delgate to dynamically change the order
            }
        }
    }
    
    var isOrderBilled: Bool = false
    private let menuItems: [MenuItem]
    
    var orderStatus: OrderStatus {
        return _orderStatus
    }
    
    var orderId: UUID {
        return _orderId
    }
    
    
    
    init(_orderId: UUID, tableId: UUID, _orderStatus: OrderStatus, menuItems: [MenuItem]) {
        self._orderId = _orderId
        self.tableId = tableId
        self._orderStatus = _orderStatus
        self.menuItems = menuItems
    }
    
    convenience init(tableId: UUID, orderStatus: OrderStatus, menuItems: [MenuItem]) {
        self.init(_orderId: UUID(), tableId: tableId, _orderStatus: orderStatus, menuItems: menuItems)
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



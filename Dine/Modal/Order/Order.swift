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
    private let orderId: UUID
    private let tableId: UUID
    var isOrderBilled: Bool
    private var orderStatus: OrderStatus
    
    var menuItems: [MenuItem]
    
    // Computed property for order status
    var orderStatusValue: OrderStatus {
        get { return orderStatus }
        set { orderStatus = newValue }
    }
    
    var orderIdValue: UUID {
        orderId
    }
    
    // Initializer with all properties
    init(orderId: UUID, tableId: UUID, orderStatus: OrderStatus, isOrderBilled: Bool, menuItems: [MenuItem]) {
        self.orderId = orderId
        self.tableId = tableId
        self.orderStatus = orderStatus
        self.isOrderBilled = isOrderBilled
        self.menuItems = menuItems
    }
    
    // Convenience initializer with only required properties
    convenience init(tableId: UUID, orderStatus: OrderStatus, menuItems: [MenuItem]) {
        self.init(orderId: UUID(), tableId: tableId, orderStatus: orderStatus, isOrderBilled: false, menuItems: menuItems)
    }
    
    // Improved displayOrderItems function
    func displayOrderItems() {
        for (index, item) in menuItems.enumerated() {
            print("\(index + 1). \(item.name) - $\(String(format: "%.2f", item.price))") // Use String.format for better formatting
        }
    }
    
    // Helper function to get item IDs as a comma-separated string
    private func itemIdsCSVString() -> String {
        return menuItems.map { $0.itemId.uuidString }.joined(separator: ",") // Use map and joined for cleaner syntax
    }
    
    // Generate CSV string using computed property and helper function
    var csvString: String {
        return "\(orderId),\(tableId),\(isOrderBilled),\(orderStatusValue.rawValue),\(itemIdsCSVString())"
    }
    
    // Change order status function with safer update
    func changeOrderStatus(to newStatus: OrderStatus) {
        guard newStatus != orderStatusValue else { return } // Avoid unnecessary updates
        orderStatusValue = newStatus
    }
}



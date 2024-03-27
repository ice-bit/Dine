//
//  OrderItemDSO.swift
//  Dine
//
//  Created by doss-zstch1212 on 26/03/24.
//

import Foundation

struct OrderItemDSO {
    let orderID: UUID
    let menuItemID: UUID
    let quantity: Int
}

extension OrderItemDSO: SQLInsertable {
    var createInsertStatement: String {
        """
        INSERT INTO \(DatabaseTables.orderMenuItemTable.rawValue) (OrderID, MenuItemID, Quantity)
        VALUES ('\(orderID.uuidString)', '\(menuItemID.uuidString)', \(quantity));
        """
    }
}

//
//  OrderMenuItem.swift
//  Dine
//
//  Created by doss-zstch1212 on 21/03/24.
//

import Foundation
import SQLite3

struct OrderItem {
    let orderID: UUID?
    let menuItemID: UUID
    let menuItemName: String
    let price: Double
    let quantity: Int
}
extension OrderItem: SQLTable {
    static var createStatement: String {
        """
        CREATE TABLE \(DatabaseTables.orderMenuItemTable.rawValue) (
            OrderItemID INTEGER PRIMARY KEY,
            OrderID VARCHAR(32) NOT NULL,
            MenuItemID VARCHAR(32) NOT NULL,
            Quantity INT NOT NULL,
            FOREIGN KEY (OrderID) REFERENCES OrderData(OrderID),
            FOREIGN KEY (MenuItemID) REFERENCES MenuItems(MenuItemID)
        );
        """
    }
}

extension OrderItem: SQLInsertable {
    var createInsertStatement: String {
        guard let orderID = self.orderID else {
            print("No OrderID found.")
            return ""
        }
        return """
        INSERT INTO \(DatabaseTables.orderMenuItemTable.rawValue) (OrderID, MenuItemID, Quantity)
        VALUES ('\(orderID.uuidString)', '\(menuItemID.uuidString)', \(quantity));
        """
    }
}

extension OrderItem: DatabaseParsable {
    static func parseRow(statement: OpaquePointer?) throws -> OrderItem? {
        guard let statement = statement else { return nil }
        guard let itemIdCString = sqlite3_column_text(statement, 0),
              let nameCString = sqlite3_column_text(statement, 1) else {
            throw DatabaseError.missingRequiredValue
        }
        
        let name = String(cString: nameCString)
        let price = sqlite3_column_double(statement, 2)
        
        let quantityPointer = sqlite3_column_int(statement, 3)
        let resultQuantity = Int(quantityPointer)
        guard let itemId = UUID(uuidString: String(cString: itemIdCString)) else {
            throw DatabaseError.conversionFailed
        }
        
        let orderMenuItem = OrderItem(orderID: nil, menuItemID: itemId, menuItemName: name, price: price, quantity: resultQuantity)
        return orderMenuItem
    }
}

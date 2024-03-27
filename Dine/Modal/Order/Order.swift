//
//  Order.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation
import SQLite3

class Order {
    private let orderId: UUID
    private let tableId: UUID
    private var isOrderBilled: Bool
    private let orderDate: Date
    var menuItems: [MenuItem]
    private var orderStatus: OrderStatus {
        /// Both `willSet` and `didSet` will not get executed!
        /// Why? - Since the ``orderStatusValue`` setter directly assigns the value to the internal property, it behaves like an internal change and might bypass the property observers.
        willSet {
            print("Order status will change to \(newValue)")
        }
        didSet {
            print("Order status did change to \(orderStatus)")
        }
    }
    init(orderId: UUID, tableId: UUID, isOrderBilled: Bool, orderDate: Date, menuItems: [MenuItem], orderStatus: OrderStatus) {
        self.orderId = orderId
        self.tableId = tableId
        self.isOrderBilled = isOrderBilled
        self.orderDate = orderDate
        self.menuItems = menuItems
        self.orderStatus = orderStatus
    }
    convenience init(tableId: UUID, orderStatus: OrderStatus, menuItems: [MenuItem]) {
        self.init(orderId: UUID(), tableId: tableId, isOrderBilled: false, orderDate: Date(), menuItems: menuItems, orderStatus: orderStatus)
    }
    var orderStatusValue: OrderStatus {
        get { return orderStatus }
        set {
            orderStatus = newValue
            if newValue == .completed {
                changeTableStatus(.free)
            }
        }
    }
    var isOrderBilledValue: Bool {
        get { return isOrderBilled }
        set { isOrderBilled = newValue }
    }
    var orderIdValue: UUID {
        orderId
    }
    var tableIDValue: UUID {
        tableId
    }
    
    // Improved displayOrderItems function
    func displayOrderItems() {
        for (index, item) in menuItems.enumerated() {
            print(" ~ \(index + 1). \(item.name) - $\(String(format: "%.2f", item.price))") // Use String.format for better formatting
        }
    }
    private func changeTableStatus(_ status: TableStatus) {
        guard let databaseAccess = try? SQLiteDataAccess.openDatabase() else {
            print("Failed to open DB connection.")
            return
        }
        do {
            let tableName = DatabaseTables.restaurantTable.rawValue
            try databaseAccess.update(tableName: tableName, columnValuePairs: ["TableStatus": "'\(TableStatus.free.rawValue)'"], condition: "TableID = '\(tableId)'")
        } catch {
            print("Error updating table status: \(error)")
        }
    }
}

extension Order: SQLTable {
    static var createStatement: String {
        """
        CREATE TABLE \(DatabaseTables.orderTable.rawValue) (
            OrderID VARCHAR(32) PRIMARY KEY,
            TableID VARCHAR(32) NOT NULL,
            OrderDateTime TEXT NOT NULL,
            OrderStatus VARCHAR(255) NOT NULL,
            OrderIsBilled INT NOT NULL,
            FOREIGN KEY (TableID) REFERENCES Tables(TableID)
        );
        """
    }
}

extension Order: SQLDeletable {
    var createDeleteStatement: String {
        "DELETE FROM \(DatabaseTables.orderTable.rawValue) WHERE OrderID = '\(orderId)';"
    }
}

extension Order: SQLInsertable {
    var createInsertStatement: String{
        """
        INSERT INTO \(DatabaseTables.orderTable.rawValue) (OrderID, TableID, OrderDateTime, OrderStatus, OrderIsBilled)
        VALUES ('\(orderId.uuidString)', '\(tableId.uuidString)', '\(orderDate)', '\(orderStatus.rawValue)', \(isOrderBilled ? 1 : 0));
        """
    }
}

extension Order: SQLUpdatable {
    var createUpdateStatement: String {
        """
        UPDATE \(DatabaseTables.orderTable.rawValue)
        SET TableID = '\(tableId)',
            OrderDateTime = '\(orderDate)',
            OrderStatus = '\(orderStatus)',
            OrderIsBilled = \(isOrderBilled ? 1 : 0)
        WHERE OrderID = '\(orderId)';
        """
    }
}

extension Order: DatabaseParsable {
    static func parseRow(statement: OpaquePointer?) throws -> Order? {
        guard let statement = statement else { return nil }
        guard let orderIdCString = sqlite3_column_text(statement, 0),
              let tableIdCString = sqlite3_column_text(statement, 1),
              let dateCString = sqlite3_column_text(statement, 2),
              let orderStatusCString = sqlite3_column_text(statement, 3) else {
            throw DatabaseError.missingRequiredValue
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        guard let date = dateFormatter.date(from: String(cString: dateCString)) else {
            print("Date conversion failed")
            return nil
        }
        
        let isOrderBilled = Int(sqlite3_column_int(statement, 4))
        let orderId = UUID(uuidString: String(cString: orderIdCString))
        let tableId = UUID(uuidString: String(cString: tableIdCString))
        let orderStatus = OrderStatus(rawValue: String(cString: orderStatusCString)) ?? .none // Provide a default value if parsing fails
        
        guard let validOrderId = orderId, let validTableId = tableId else {
            throw DatabaseError.conversionFailed
        }
        
        if isOrderBilled == 1 {
            let order = Order(orderId: validOrderId, tableId: validTableId, isOrderBilled: true, orderDate: date, menuItems: [], orderStatus: orderStatus)
            return order
        }
        
        let order = Order(orderId: validOrderId, tableId: validTableId, isOrderBilled: false, orderDate: date, menuItems: [], orderStatus: orderStatus)
        return order
    }
}

enum OrderStatus: String, CaseIterable {
    case received
    case preparing
    case completed
    case cancelled
    case none
}




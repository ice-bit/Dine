//
//  MenuItem.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation
import SQLite3

class MenuItem {
    let itemId: UUID
    var name: String
    var price: Double
    init(itemId: UUID, name: String, price: Double) {
        self.itemId = itemId
        self.name = name
        self.price = price
    }
    convenience init(name: String, price: Double) {
        self.init(itemId: UUID(), name: name, price: price)
    }
}

extension MenuItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(itemId)
    }
    
    static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.itemId == rhs.itemId
    }
}

extension MenuItem: Parsable {}

extension MenuItem: SQLTable {
    static var createStatement: String {
        """
        CREATE TABLE \(DatabaseTables.menuItem.rawValue) (
            MenuItemID VARCHAR(32) PRIMARY KEY,
            MenuItemName VARCHAR(255) NOT NULL,
            Price DECIMAL(10,2) NOT NULL
        );        
        """
    }
}

extension MenuItem: SQLUpdatable {
    var createUpdateStatement: String {
        """
        UPDATE \(DatabaseTables.menuItem.rawValue)
        SET MenuItemID = '\(itemId)', MenuItemName = '\(name)', Price = \(price)
        WHERE MenuItemID = '\(itemId)';
        """
    }
}

extension MenuItem: SQLDeletable {
    var createDeleteStatement: String {
        "DELETE FROM \(DatabaseTables.menuItem.rawValue) WHERE MenuItemID = '\(itemId)'"
    }
}

extension MenuItem: SQLInsertable {
    var createInsertStatement: String {
        """
        INSERT INTO \(DatabaseTables.menuItem.rawValue) (MenuItemID, MenuItemName, Price)
        VALUES ('\(itemId)', '\(name)', \(price));
        """
    }
}

extension MenuItem: DatabaseParsable {
    static func parseRow(statement: OpaquePointer?) throws -> MenuItem? {
        guard let statement = statement else { return nil }
        guard let itemIdCString = sqlite3_column_text(statement, 0),
              let nameCString = sqlite3_column_text(statement, 1) else {
            throw DatabaseError.missingRequiredValue
        }
        
        let name = String(cString: nameCString)
        let price = sqlite3_column_double(statement, 2)
        
        guard let itemId = UUID(uuidString: String(cString: itemIdCString)) else {
            throw DatabaseError.conversionFailed
        }
        
        let menuItem = MenuItem(itemId: itemId, name: name, price: price)
        return menuItem
    }
}

//
//  Table.swift
//  Dine
//
//  Created by doss-zstch1212 on 25/01/24.
//

import Foundation
import SQLite3

enum TableStatus: String, CaseIterable {
    case free, reserved, occupied, other
}

class RestaurantTable {
    private let _tableId: UUID
    var tableStatus: TableStatus
    private let maxCapacity: Int
    private let _locationIdentifier: Int
    
    var tableId: UUID {
        return _tableId
    }
    
    var locationId: Int {
        return _locationIdentifier
    }
    
    init(tableId: UUID, tableStatus: TableStatus, maxCapacity: Int, locationIdentifier: Int) {
        self._tableId = tableId
        self.tableStatus = tableStatus
        self.maxCapacity = maxCapacity
        self._locationIdentifier = locationIdentifier
    }
    
    convenience init(tableStatus: TableStatus, maxCapacity: Int, locationIdentifier: Int) {
        self.init(tableId: UUID(), tableStatus: tableStatus, maxCapacity: maxCapacity, locationIdentifier: locationIdentifier)
    }
    
    func changeTableStatus(to status: TableStatus) {
        tableStatus = status
    }
    
    func getCSVString() -> String {
        return "\(_tableId),\(tableStatus.rawValue),\(maxCapacity),\(_locationIdentifier)"
    }
    
}

extension RestaurantTable: Parsable {}

extension RestaurantTable: SQLTable {
    static var createStatement: String {
        """
        CREATE TABLE \(DatabaseTables.restaurantTable.rawValue) (
          TableID VARCHAR(32) PRIMARY KEY,
          TableStatus VARCHAR(255),
          MaxCapacity INTEGER,
          LocationIdentifier INTEGER
        );
        """
    }
}

extension RestaurantTable: SQLUpdatable {
    var createUpdateStatement: String {
        """
        UPDATE \(DatabaseTables.restaurantTable.rawValue)
        SET TableID = '\(tableId)', TableStatus = '\(tableStatus.rawValue)', MaxCapacity = \(maxCapacity), LocationIdentifier = \(locationId)
        WHERE TableID = '\(tableId)'
        """
    }
}

extension RestaurantTable: SQLInsertable {
    var createInsertStatement: String {
        """
        INSERT INTO \(DatabaseTables.restaurantTable.rawValue) (TableID, TableStatus, MaxCapacity, LocationIdentifier)
        VALUES ('\(tableId.uuidString)', '\(tableStatus.rawValue)', \(maxCapacity), \(_locationIdentifier));
        """
    }
}

extension RestaurantTable: SQLDeletable {
    var createDeleteStatement: String {
        "DELETE FROM \(DatabaseTables.restaurantTable.rawValue) WHERE TableID = '\(tableId)';"
    }
}

extension RestaurantTable: DatabaseParsable {
    static func parseRow(statement: OpaquePointer?) throws -> RestaurantTable? {
        guard let statement = statement else { return nil }
        guard let tableIdCString = sqlite3_column_text(statement, 0),
              let statusCString = sqlite3_column_text(statement, 1) else {
            throw DatabaseError.missingRequiredValue
        }
        
        let maxCapacity = Int(sqlite3_column_int(statement, 2))
        let locationIdentifier = Int(sqlite3_column_int(statement, 3))
        
        guard let tableId = UUID(uuidString: String(cString: tableIdCString)),
              let status = TableStatus(rawValue: String(cString: statusCString)) else {
            throw DatabaseError.conversionFailed
        }
        
        let restaurantTable = RestaurantTable(tableId: tableId, tableStatus: status, maxCapacity: maxCapacity, locationIdentifier: locationIdentifier)
        return restaurantTable
    }
}



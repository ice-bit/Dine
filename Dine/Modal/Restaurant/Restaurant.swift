//
//  Restaurant.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation
import SQLite3

class Restaurant: Codable {
    private var restaurantId: UUID
    private var name: String
    private var location: String
    
    init(restaurantId: UUID, name: String, location: String) {
        self.restaurantId = restaurantId
        self.name = name
        self.location = location
    }
    
    convenience init(name: String, location: String) {
        self.init(restaurantId: UUID(), name: name, location: location)
    }
}

extension Restaurant: SQLInsertable, SQLTable {
    static var createStatement: String {
        """
        CREATE TABLE \(DatabaseTables.restaurantDBTable.rawValue) (
            RestaurantID CHAR(36) PRIMARY KEY,
            Name VARCHAR(255) NOT NULL,
            Location VARCHAR(255) NOT NULL
        );
        """
    }
    var createInsertStatement: String {
        """
        INSERT INTO \(DatabaseTables.restaurantDBTable.rawValue) (RestaurantID, Name, Location)
        VALUES ('\(restaurantId)', '\(name)', '\(location)');
        """
    }
}

extension Restaurant: DatabaseParsable {
    static func parseRow(statement: OpaquePointer?) throws -> Restaurant? {
        guard let statement = statement else { return nil}
        guard let restaurantIdCString = sqlite3_column_text(statement, 0),
              let nameCString = sqlite3_column_text(statement, 1),
              let locationCString = sqlite3_column_text(statement, 2) else {
            throw DatabaseError.conversionFailed
        }
        let name = String(cString: nameCString)
        let location = String(cString: locationCString)
        
        guard let restaurantId = UUID(uuidString: String(cString: restaurantIdCString)) else {
            throw DatabaseError.conversionFailed
        }
        let restaurant = Restaurant(restaurantId: restaurantId, name: name, location: location)
        return restaurant
    }
}

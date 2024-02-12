//
//  Restaurant.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Restaurant {
    private var name: String
    private var restaurantId: UUID
    private var location: String
    
    var menu: Menu
    
    var tables: [Table]
    
    var tablesCount: Int {
        return tables.count
    }
    
    var availableTables: [Table] {
        return tables.filter { $0.tableStatus == .free }
    }
    
    init(name: String, location: String, menu: Menu, tables: [Table]) {
        self.name = name
        self.restaurantId = UUID()
        self.location = location
        self.menu = menu
        self.tables = tables
    }
    
    /// Create instance of `Restaurant` with empty array of `Table`.
    convenience init(name: String, location: String, menu: Menu) {
        self.init(name: name, location: location, menu: menu, tables: [])
    }
    
    /// Create instance of `Restaurant` with default `Menu`.
    /// - SeeAlso: Convenience init of `Menu`.
    convenience init(name: String, location: String) {
        self.init(name: name, location: location, menu: Menu(), tables: [])
    }
    
}

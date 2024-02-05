//
//  Branch.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Branch: Codable {
    private var _branchId: UUID
    private var branchName: String
    private var location: String
    
    private var kitchen: Kitchen
    private var menu: Menu
    
    private var tables: [Table]
    
    var branchId: UUID {
        return _branchId
    }
    
    var availableTables: [Table] {
        return tables.filter { $0.tableStatus == .free }
    }
    
    init(_branchId: UUID, branchName: String, location: String, kitchen: Kitchen, menu: Menu, tables: [Table]) {
        self._branchId = _branchId
        self.branchName = branchName
        self.location = location
        self.kitchen = kitchen
        self.menu = menu
        self.tables = tables
    }
    
    convenience init(branchName: String, location: String) {
        self.init(_branchId: UUID(), branchName: branchName, location: location, kitchen: Kitchen(), menu: Menu(), tables: [])
    }
}

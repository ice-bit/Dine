//
//  Table.swift
//  Dine
//
//  Created by doss-zstch1212 on 25/01/24.
//

import Foundation

enum TableStatus: Codable, CaseIterable {
    case free, reserved, occupied, other
}

class Table: Codable {
    private let tableId: UUID
    private var _tableStatus: TableStatus
    private let maxCapacity: Int
    private let locationIdentifier: Int
    
    var tableStatus: TableStatus {
        return _tableStatus
    }
    
    init(status: TableStatus, maxCapacity: Int, locationIdentifier: Int) {
        self.tableId = UUID()
        self._tableStatus = status
        self.maxCapacity = maxCapacity
        self.locationIdentifier = locationIdentifier
    }
    
    func getTableId() -> String {
        return tableId.uuidString
    }
    
    func getTableLocationId() -> Int {
        return locationIdentifier
    }
    
    func changeTableStatus(to status: TableStatus) {
        _tableStatus = status
    }
    
}

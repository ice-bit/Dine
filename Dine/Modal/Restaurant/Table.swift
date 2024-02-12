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
    private let _tableId: UUID
    private var _tableStatus: TableStatus
    private let maxCapacity: Int
    private let _locationIdentifier: Int
    
    var tableId: UUID {
        return _tableId
    }
    
    var tableStatus: TableStatus {
        return _tableStatus
    }
    
    var locationId: Int {
        return _locationIdentifier
    }
    
    init(status: TableStatus, maxCapacity: Int, locationIdentifier: Int) {
        self._tableId = UUID()
        self._tableStatus = status
        self.maxCapacity = maxCapacity
        self._locationIdentifier = locationIdentifier
    }
    
    convenience init(maxCapacity: Int, locationIdentifier: Int) {
        self.init(status: .free, maxCapacity: maxCapacity, locationIdentifier: locationIdentifier)
    }
    
    func changeTableStatus(to status: TableStatus) {
        _tableStatus = status
    }
    
}

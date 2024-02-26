//
//  Table.swift
//  Dine
//
//  Created by doss-zstch1212 on 25/01/24.
//

import Foundation

enum TableStatus: String, CaseIterable {
    case free, reserved, occupied, other
}

class Table {
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
    
    init(tableId: UUID, tableStatus: TableStatus, maxCapacity: Int, locationIdentifier: Int) {
        self._tableId = tableId
        self._tableStatus = tableStatus
        self.maxCapacity = maxCapacity
        self._locationIdentifier = locationIdentifier
    }
    
    convenience init(tableStatus: TableStatus, maxCapacity: Int, locationIdentifier: Int) {
        self.init(tableId: UUID(), tableStatus: tableStatus, maxCapacity: maxCapacity, locationIdentifier: locationIdentifier)
    }
    
    func changeTableStatus(to status: TableStatus) {
        _tableStatus = status
    }
    
    func getCSVString() -> String {
        return "\(_tableId),\(_tableStatus.rawValue),\(maxCapacity),\(_locationIdentifier)"
    }
    
}

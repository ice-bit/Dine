//
//  Table.swift
//  Dine
//
//  Created by doss-zstch1212 on 25/01/24.
//

import Foundation

enum TableStatus {
    case free, reserved, occupied, other
}

class Table {
    private let status: TableStatus
    private let maxCapacity: Int
    private let locationIdentifier: Int
    
    init(status: TableStatus, maxCapacity: Int, locationIdentifier: Int) {
        self.status = status
        self.maxCapacity = maxCapacity
        self.locationIdentifier = locationIdentifier
    }
}

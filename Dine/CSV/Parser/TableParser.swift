//
//  TableParser.swift
//  Dine
//
//  Created by doss-zstch1212 on 07/03/24.
//

import Foundation

struct TableParser: CSVParsable {
    typealias Entity = Table
    
    func parse(from data: [[String : String]]) -> [Table] {
        data.compactMap(parseTable)
    }
    
    private func parseTable(from tableData: [String: String]) -> Table? {
        guard let tableUUIDString = tableData["tableId"],
              !tableUUIDString.isEmpty,
              let tableId = UUID(uuidString: tableUUIDString),
              let tableStatusString = tableData["tableStatus"],
              let tableStatus = TableStatus(rawValue: tableStatusString),
              let maxCapacityString = tableData["maxCapacity"],
              let maxCapacity = Int(maxCapacityString),
              let locationIdentifierString = tableData["maxCapacity"],
              let locationIdentifier = Int(locationIdentifierString) else {
     return nil
        }
        
        return Table(tableId: tableId, tableStatus: tableStatus, maxCapacity: maxCapacity, locationIdentifier: locationIdentifier)
    }
}

//
//  CSVParser.swift
//  Dine
//
//  Created by doss-zstch1212 on 23/02/24.
//

import Foundation

struct CSVParser {
    func parseAccounts(from data: [[String: String]]) -> [Account] {
        return data.compactMap(parseAccount)
    }
    
//    func parseOrders(from data: [[String: String]]) -> [Order] {
//        
//    }
    
    func parseTables(from data: [[String: String]]) -> [Table] {
        return data.compactMap(parseTable)
    }
//    
//    func parseBills(from data: [[String: String]]) -> [Bill] {
//        
//    }

    private func parseAccount(from userData: [String: String]) -> Account? {
        guard let userIdString = userData["userId"],
            !userIdString.isEmpty,
            let userId = UUID(uuidString: userIdString),
            let username = userData["username"],
            let password = userData["password"],
            let accountStatusString = userData["accountStatus"],
            let accountStatus = AccountStatus(rawValue: accountStatusString),
            let userRoleString = userData["userRole"],
            let userRole = UserRole(rawValue: userRoleString) else {
            return nil
        }

        return Account(userId: userId, username: username, password: password, accountStatus: accountStatus, userRole: userRole)
    }
    
//    private func parseOrder(from orderData: [String: String]) -> Order? {
//        
//    }
    
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
    
//    private func parseBill(from billData: [String: String]) -> Bill? {
//        
//    }
    
}

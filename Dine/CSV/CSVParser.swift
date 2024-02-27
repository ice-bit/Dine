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
    
    func parseOrders(from data: [[String: String]]) -> [Order] {
        return data.compactMap(parseOrder)
    }
    
    func parseTables(from data: [[String: String]]) -> [Table] {
        return data.compactMap(parseTable)
    }
    
    func parseBills(from data: [[String: String]]) -> [Bill] {
        return data.compactMap(parseBill(from:))
    }
    
    func parseMenu(from data: [[String: String]]) -> [MenuItem] {
        return data.compactMap(parseMenuItem)
    }
    
    private func parseMenuItem(from menuData: [String: String]) -> MenuItem? {
        guard let itemUUIDString = menuData["itemId"],
              let itemId = UUID(uuidString: itemUUIDString),
              let name = menuData["name"],
              let priceString = menuData["price"],
              let price = Double(priceString) else {
            return nil
        }
        
        return MenuItem(itemId: itemId, name: name, price: price)
    }

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
    
    private func parseOrder(from orderData: [String: String]) -> Order? {
        return nil
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
    
    private func parseBill(from billData: [String: String]) -> Bill? {
        guard let billUUIDString = billData["billId"],
              let billId = UUID(uuidString: billUUIDString),
              let amountString = billData["amount"],
              let amount = Double(amountString),
              let dateString = billData["date"],
              let date = dateString.toData(withFormat: "yyyy-MM-dd HH:mm:ss Z"),
              let tipString = billData["tip"],
              let tip = Double(tipString),
              let taxString = billData["tax"],
              let tax = Double(taxString),
              let isPaidString = billData["isPaid"],
              let isPaid = Bool(isPaidString) else {
            return nil
        }
        
        return Bill(_billId: billId, amount: amount, date: date, tip: tip, tax: tax, isPaid: isPaid)
    }
    
}

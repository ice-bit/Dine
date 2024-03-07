//
//  OrderParser.swift
//  Dine
//
//  Created by doss-zstch1212 on 07/03/24.
//

import Foundation

struct OrderParser {
    func parseOrders(from data: [[String]]) -> [Order] {
         data.compactMap(parseOrder)
    }
    
    private func parseOrder(from orderData: [String]) -> Order? {
        guard orderData.count >= 4 else { return nil }
        
        // Extract order information
        guard let orderId = UUID(uuidString:orderData[0]),
              let tableId = UUID(uuidString: orderData[1]),
              let isOrderBilled = Bool(orderData[2]),
              let orderStatus = OrderStatus(rawValue: orderData[3]) else {
            return nil
        }
        
        // extract
        var mappedMenuItems = [MenuItem]()
        for index in 4..<orderData.count {
            if let itemId = UUID(uuidString: orderData[index]) {
                if let menuItem = Menu.shared.fetchMenuItem(with: itemId) {
                    mappedMenuItems.append(menuItem)
                } else {
                    print("Go check menu")
                }
            } else {
                print("Bruh!")
            }
        }
        
        return Order(orderId: orderId, tableId: tableId, orderStatus: orderStatus, isOrderBilled: isOrderBilled, menuItems: mappedMenuItems)
    }
}

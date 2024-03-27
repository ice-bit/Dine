////
////  OrderParser.swift
////  Dine
////
////  Created by doss-zstch1212 on 07/03/24.
////
//
//import Foundation
//
//struct OrderParser {
//    func parseOrders(from data: [[String]]) throws -> [Order] {
//         try data.compactMap(parseOrder)
//    }
//    
//    private func parseOrder(from orderData: [String]) throws -> Order? {
//        let menu = Menu.shared
//        guard !menu.menuItems.isEmpty else {
//            throw LoadingError.menuItemsNotLoaded
//        }
//        guard orderData.count >= 4 else { return nil }
//
//        // Extract order information
//        guard let orderId = UUID(uuidString:orderData[0]),
//              let tableId = UUID(uuidString: orderData[1]),
//              let isOrderBilled = Bool(orderData[2]),
//              let orderStatus = OrderStatus(rawValue: orderData[3]) else {
//            throw CSVParseError.parsingFailed
//        }
//        
//        // extract
//        var mappedMenuItems = [MenuItem]()
//        for index in 4..<orderData.count {
//            if let itemId = UUID(uuidString: orderData[index]) {
//                if let menuItem = menu.fetchMenuItem(with: itemId) {
//                    mappedMenuItems.append(menuItem)
//                } else {
//                    print("Menu not loaded")
//                }
//            } else {
//                print("Not valid UUID")
//            }
//        }
//        
//        return Order(orderId: orderId, tableId: tableId, isOrderBilled: isOrderBilled, menuItems: mappedMenuItems, orderStatus: orderStatus)
//    }
//}
//
//enum LoadingError: Error {
//    case menuItemsNotLoaded
//}

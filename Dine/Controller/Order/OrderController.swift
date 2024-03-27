//
//  OrderController.swift
//  Dine
//
//  Created by doss-zstch1212 on 24/01/24.
//

import Foundation

protocol OrderServicable {
    func createOrder(for table: RestaurantTable, menuItems: [MenuItem: Int]) throws
    func getOrdersCount() -> Int?
    func displayOrders()
    func getUnbilledOrders() -> [Order]?
}

class OrderController: OrderServicable {
    private let orderService: OrderService
    private let tableService: TableService
    init(orderService: OrderService, tableService: TableService) {
        self.orderService = orderService
        self.tableService = tableService
    }
    
    func createOrder(for table: RestaurantTable, menuItems: [MenuItem: Int]) throws {
        var orderMenuItems: [MenuItem] = []
        
        // Iterate through the dictionary of menu item quantities
        let orderID = UUID()
        for (menuItem, quantity) in menuItems {
            // Append the menu item to the array the specified number of times
            orderMenuItems.append(contentsOf: Array(repeating: menuItem, count: quantity))
            // Add to join table
            let orderitem = OrderItem(orderID: orderID, menuItemID: menuItem.itemId, menuItemName: menuItem.name, price: menuItem.price, quantity: quantity)
            try orderService.add(orderitem)
        }
        let order = Order(orderId: orderID, tableId: table.tableId, isOrderBilled: false, orderDate: Date(), menuItems: orderMenuItems, orderStatus: .received)
        // Change order status
        guard let resultTables = try tableService.fetch() else {
            print("Failed to fetch tables")
            return
        }
        guard let tableIndex = resultTables.firstIndex(where: { $0.tableId == table.tableId }) else {
            print("No tables found under UUID: \(table.tableId) for updating")
            return
        }
        let choosenTable = resultTables[tableIndex]
        choosenTable.tableStatus = .occupied
        try orderService.add(order)
        try tableService.update(choosenTable)
    }
    
    func getOrdersCount() -> Int? {
        guard let resultOrder = try? orderService.fetch() else {
            print("No orders found.")
            return nil
        }
        return resultOrder.count
    }
    
    func displayOrders() {
        guard let resultOrder = try? orderService.fetch() else {
            print("No orders found")
            return
        }
        for (index, order) in resultOrder.enumerated() {
            print("\(index + 1). Order: \(order.orderIdValue)")
            print(" - Ordered Items:")
            print(" - \(order.displayOrderItems())\n")
        }
    }
    
    func getUnbilledOrders() -> [Order]? {
        guard let resultOrder = try? orderService.fetch() else {
            print("No orders found")
            return nil
        }
        let unbilledOrders = resultOrder.filter { $0.isOrderBilledValue == false }
        return unbilledOrders
    }
}

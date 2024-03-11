//
//  OrderManager.swift
//  Dine
//
//  Created by doss-zstch1212 on 29/01/24.
//

import Foundation

class OrderManager {
    static let shared = OrderManager()
    
    private init() {
        loadOrders()
    }
    
    private var orders: [Order] = []
    
    var ordersCount: Int {
        orders.count
    }
    
    func addOrder( order: Order) {
        orders.append(order)
        saveOrders()
    }
    
    func removeOrder(_ order: Order) -> Bool {
        guard let orderIndex = orders.firstIndex(where: { $0.orderIdValue == order.orderIdValue }) else {
            return false
        }
        
        orders.remove(at: orderIndex)
        saveOrders()
        
        return true
    }
    
    func getUncompletedOrders() -> [Order] {
        orders.filter({ $0.orderStatusValue == .received || $0.orderStatusValue == .preparing })
    }
    
    // Orders that are completed
    func getUnbilledOrders() -> [Order]? {
        let unbilledOrders = orders.filter { $0.isOrderBilled == false && $0.orderStatusValue == .completed }
        
        guard !unbilledOrders.isEmpty else { return nil }
        
        return unbilledOrders
    }
    
    func displayOrders() {
        for (index, order) in orders.enumerated() {
            print("\(index + 1). Order: \(order.orderIdValue)")
            print(" - Ordered Items:")
            print(" - \(order.displayOrderItems())")
        }
    }
    
    func saveOrders() {
//        Task {
            let csvDAO = CSVDataAccessObject()
            /*await*/ csvDAO.save(to: .orderFile, entity: self)
//        }
    }
  
    func loadOrders() {
//        Task {
            let csvReader = CSVReader()
            let orderParser = OrderParser()
            do {
                let data = try /*await*/ csvReader.readCSVAs2DArray(from: Filename.orderFile.rawValue)
                let fetchedOrders = try orderParser.parseOrders(from: data)
                self.orders = fetchedOrders
            } catch is LoadingError {
                print("Menu items not loaded")
            } catch {
                print("Error encountered: \(error)")
            }
//        }
    }
}

extension OrderManager: CSVWritable {
    func toCSVString() -> String {
        var csvString = "orderId,tableId,isOrderBilled,orderStatus,itemIds"
        for (index, order) in orders.enumerated() {
            if index != self.orders.count {
                csvString.append("\n")
            }
            
            let row = order.csvString
            csvString.append(row)
        }
        
        return csvString
    }
}

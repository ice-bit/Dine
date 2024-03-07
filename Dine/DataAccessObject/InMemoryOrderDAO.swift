////
////  OrderDAO.swift
////  Dine
////
////  Created by doss-zstch1212 on 05/03/24.
////
//
//import Foundation
//
//class InMemoryOrderDAO: DataAccessObject {
//    typealias DataType = Order
//    private var orders = [Order]()
//
//    func add(_ entity: Order) {
//        orders.append(entity)
//    }
//    
//    func get() -> [Order] {
//        return orders
//    }
//    
//    func update(_ entity: Order) {
//        if let index = orders.firstIndex(where: { $0.orderIdValue == entity.orderIdValue }) {
//            orders[index] = entity
//        } else {
//            print("Order not found.")
//        }
//    }
//    
//    func delete(_ entity: Order) {
//        if let index = orders.firstIndex(where: { $0.orderIdValue == entity.orderIdValue }) {
//            orders.remove(at: index)
//        } else {
//            print("Order not found.")
//        }
//    }
//}
//
///*func saveToFile() {
// let csvWriter = CSVWriter()
// do {
//     if try csvWriter.writeToCSV(into: Filename.orderFile.rawValue, csvDataModal: OrderManager.shared) {
//         print("SUIII!")
//     }
// } catch {
//     print("ERROR: \(error)!")
// }
//}
//
//private func loadFromFile() {
// let csvReader = CSVReader()
// let csvParser = CSVParser()
// do {
//     let data = try csvReader.readCSVAs2DArray(from: Filename.orderFile.rawValue)
//     let orders = csvParser.parseOrders(from: data)
// } catch {
//     print("ERROR: \(error)!")
// }
//}*/

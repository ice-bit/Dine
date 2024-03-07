////
////  InMemoryBillDAO.swift
////  Dine
////
////  Created by doss-zstch1212 on 06/03/24.
////
//
//import Foundation
//
//class InMemoryBillDAO: DataAccessObject {
//    func add(_ entity: Bill) {
//        bills.append(entity)
//    }
//    
//    func get() -> [Bill] {
//        return bills
//    }
//    
//    func update(_ entity: Bill) throws {
//        if let index = bills.firstIndex(where: { $0.billId == entity.billId }) {
//            bills[index] = entity
//        } else {
//            print("Bills not found.")
//        }
//    }
//    
//    func delete(_ entity: Bill) throws {
//        if let index = bills.firstIndex(where: { $0.billId == entity.billId }) {
//            bills.remove(at: index)
//        } else {
//            print("Bill not found.")
//        }
//    }
//    
//    func save(to file: Filename, entity: CSVWritable) {
//        <#code#>
//    }
//    
//    typealias Entity = Bill
//    var bills = [Bill]()
//
//}

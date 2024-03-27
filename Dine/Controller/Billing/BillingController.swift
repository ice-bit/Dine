//
//  BillingController.swift
//  Dine
//
//  Created by doss-zstch1212 on 29/01/24.
//

import Foundation

protocol BillServicable {
    func createBill(for order: Order, tip: Double?) throws
    func fetchBills() -> [Bill]?
    func getUnbilledOrders() -> [Order]?
}

class BillingController: BillServicable {
    private let billService: BillService
    private let orderService: OrderService
    init(billService: BillService, orderService: OrderService) {
        self.billService = billService
        self.orderService = orderService
    }
    
    func createBill(for order: Order, tip: Double?) throws {
        let menuItems = order.menuItems
        let totalAmount = menuItems.reduce(0.0) { $0 + $1.price }
        let tax = totalAmount * 0.18
        
        let bill: Bill
        if let tip = tip {
            bill = Bill(amount: totalAmount, tip: tip, tax: tax, isPaid: false)
        } else {
            bill = Bill(amount: totalAmount, tax: tax, isPaid: false)
        }
        
        // Change bill status
        order.isOrderBilledValue = true
        // Change bill status
        order.orderStatusValue = .completed
        try orderService.update(order)
        try billService.add(bill)
    }
    
    func fetchBills() -> [Bill]? {
        guard let bills = try? billService.fetch() else {
            print("No bills found")
            return nil
        }
        return bills
    }
    
    func getUnbilledOrders() -> [Order]? {
        guard let resultOrders =  try? orderService.fetch() else {
            print("Failed to load orders.")
            return nil
        }
        
        let unbilledOrders = resultOrders.filter { $0.isOrderBilledValue == false }
        return unbilledOrders
    }
}

//
//  BillingController.swift
//  Dine
//
//  Created by doss-zstch1212 on 29/01/24.
//

import Foundation

class BillingController {
    private let billManager: BillManager
    
    init(billManager: BillManager) {
        self.billManager = billManager
    }
    
    func createBill(for order: Order, tip: Double? = nil) {
        let menuItems = order.orderedItems()
        let totalAmount = menuItems.reduce(0.0) { $0 + $1.price }
        let tax = totalAmount * 0.18
        
        let bill: Bill
        if let tip = tip {
            bill = Bill(amount: totalAmount, tip: tip, tax: tax, isPaid: false)
        } else {
            bill = Bill(amount: totalAmount, tax: tax, isPaid: false)
        }
        
        billManager.addBill(bill)
    }
    
    func getUnbilledOrders(from orderManager: OrderManager) -> [Order]? {
        return orderManager.getUnbilledOrders()
    }
}

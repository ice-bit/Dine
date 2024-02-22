//
//  BillingController.swift
//  Dine
//
//  Created by doss-zstch1212 on 29/01/24.
//

import Foundation

protocol BillService {
    func createBill(for order: Order, tip: Double?)
    func displayBills()
}

class BillingController: BillService {
    private let billManager = BillManager.shared
    
    func createBill(for order: Order, tip: Double?) {
        let menuItems = order.orderedItems()
        let totalAmount = menuItems.reduce(0.0) { $0 + $1.price }
        let tax = totalAmount * 0.18
        
        let bill: Bill
        if let tip = tip {
            bill = Bill(amount: totalAmount, tip: tip, tax: tax, isPaid: false)
        } else {
            bill = Bill(amount: totalAmount, tax: tax, isPaid: false)
        }
        
        // Change bill status
        order.isOrderBilled = true
        billManager.addBill(bill)
    }
    
    func displayBills() {
        billManager.displayBills()
    }
}

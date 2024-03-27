//
//  BillingConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 29/01/24.
//

import Foundation

class BillingConsoleView {
    private let billController: BillServicable
    init(billController: BillServicable) {
        self.billController = billController
    }
    
    private func displayUnbilledOrdersAndChoose() -> Order? {
        guard let unbilledOrders =  billController.getUnbilledOrders() else {
            print("Failed to load orders.")
            return nil
        }
    
        print("Unbilled Orders")
        for (index, order) in unbilledOrders.enumerated() {
            print("\(index + 1). Order: \(order.orderIdValue)")
            print("Ordered Items:")
            print(" - ")
            order.displayOrderItems()
            print()
        }
        
        print("Enter the number of the order you want to choose (or 0 to cancel):")
        if let choice = readLine(), let orderNumber = Int(choice), orderNumber >= 1, orderNumber <= unbilledOrders.count {
            let chosenUnbilledOrder = unbilledOrders[orderNumber - 1]
            print("You have chosen order: \(chosenUnbilledOrder.orderIdValue)")
            return chosenUnbilledOrder
        } else {
            print("Invalid choice or canceled.")
            return nil
        }
    }

    func generatebill() {
        guard let order = displayUnbilledOrdersAndChoose() else { return }
        do {
            try billController.createBill(for: order, tip: nil)
        } catch {
            print("Failed to create bill for \(order.orderIdValue): \(error)")
        }
        print("Bill created successfully.")
    }
    
    func displayBills() {
        guard let bills = billController.fetchBills() else {
            print("No bills found. Please generate bills.")
            return
        }
        
        for (index, bill) in bills.enumerated() {
            print("\(index + 1) - \(bill.displayBill())\n")
        }
    }
}

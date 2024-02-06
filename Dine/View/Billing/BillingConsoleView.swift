//
//  BillingConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 29/01/24.
//

import Foundation

class BillingConsoleView {
    private let billManager: BillManager
    private let orderManager: OrderManager
    
    init(billManager: BillManager, orderManager: OrderManager) {
        self.billManager = billManager
        self.orderManager = orderManager
    }
    
    private func displayUnbilledOrdersAndChoose() -> Order? {
        let billingController = BillingController(billManager: billManager, orderManager: orderManager)
        
        guard let unbilledOrders = billingController.getUnbilledOrders() else {
            print("No billed order available.")
            return nil
        }
        
        print("Unbilled Orders")
        for (index, order) in unbilledOrders.enumerated() {
            print("\(index + 1). Order: \(order.orderId)")
            print("Ordered Items:")
            print(" - \(order.displayOrderItems())")
        }
        
        print("Enter the number of the order you want to choose (or 0 to cancel):")
        if let choice = readLine(), let orderNumber = Int(choice), orderNumber >= 1, orderNumber <= unbilledOrders.count {
            let chosenUnbilledOrder = unbilledOrders[orderNumber - 1]
            print("You have chosen order: \(chosenUnbilledOrder.orderId)")
            return chosenUnbilledOrder
        } else {
            print("Invalid choice or canceled.")
            return nil
        }
    }
    
    func generatebill() {
        guard let order = displayUnbilledOrdersAndChoose() else { return }
        
        let billingController = BillingController(billManager: billManager, orderManager: orderManager)
        billingController.createBill(for: order)
        print("Bill created successfully.")
    }
    
    func viewBill() {
        let bills = billManager.bills
        for (index, bill) in bills.enumerated() {
            print("\(index). Bill: \(bill.billId)")
        }
    }
}

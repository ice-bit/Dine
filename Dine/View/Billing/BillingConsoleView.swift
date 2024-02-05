//
//  BillingConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 29/01/24.
//

import Foundation

class BillingConsoleView {
    private let branch: Branch
    
    init(branch: Branch) {
        self.branch = branch
    }
    
    func displayUnbilledOrdersAndChoose() -> Order? {
        let billingController = BillingController(billManager: branch.billManager)
        guard let unbilledOrders = billingController.getUnbilledOrders(from: branch.orderManager) else {
            return nil
        }
        
        print("Unbilled Orders")
        for (index, order) in unbilledOrders.enumerated() {
            print("\(index + 1). Order: \(order.orderId)\n\(order.displayOrderItems())")
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
        
        let billingController = BillingController(billManager: branch.billManager)
        billingController.createBill(for: order)
        print("Bill created successfully.")
    }
}

//
//  BillingConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 29/01/24.
//

import Foundation

class BillingConsoleView {
    private let billService: BillService = BillingController()
    private let orderService: OrderService = OrderController()
    
    private func displayUnbilledOrdersAndChoose() -> Order? {
        guard let unbilledOrders = orderService.getUnbilledOrders() else {
            print("No orders are ready to be billed.")
            return nil
        }
        
        print("Unbilled Orders")
        for (index, order) in unbilledOrders.enumerated() {
            print("\(index + 1). Order: \(order.orderId)")
            print("Ordered Items:")
            print(" - ")
            order.displayOrderItems()
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
        billService.createBill(for: order, tip: nil)
        print("Bill created successfully.")
    }
    
    func displayBills() {
        if let bills = billService.fetchBills() {
            for (index, bill) in bills.enumerated() {
                print("\(index + 1). Bill: \(bill.billId)")
            }
        }
    }
}

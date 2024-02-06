//
//  HomeConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 25/01/24.
//

import Foundation

class HomeConsoleView {
    private let branch: Branch
    
    private let orderManager = OrderManager()
    private let tableManager = TableManager()
    private let billManager = BillManager()
    
    init(branch: Branch) {
        self.branch = branch
    }
    
    func displayHomeOptions() {
        print("Home")
        print("1. Place Order")
        print("2. Customize Menu")
        print("3. Generate Bill")
        print("4. Update Order Status")
        print("5. View Bills")
        print("6. View Orders")
        print("7. View Menu")
        handleHomeOptions()
    }
    
    private func handleHomeOptions() {
        let choice = readLine() ?? ""
        switch choice {
        case "1":
            let orderConsoleView = OrderConsoleView(branch: branch, orderManager: orderManager, tableManager: tableManager)
            orderConsoleView.displayMenu()
        case "2":
            let menuConsoleView = MenuConsoleView(menu: branch.menu)
            menuConsoleView.displayAndHandleMenuOptions()
        case "3":
            let billConsoleView = BillingConsoleView(billManager: billManager, orderManager: orderManager)
            billConsoleView.generatebill()
        case "4":
            print()
        case "5":
            let billConsoleView = BillingConsoleView(billManager: billManager, orderManager: orderManager)
            billConsoleView.viewBill()
        case "6":
            let orderConsoleView = OrderConsoleView(branch: branch, orderManager: orderManager, tableManager: tableManager)
            orderConsoleView.viewOrders()
        case "7":
            let menuConsoleView = MenuConsoleView(menu: branch.menu)
            menuConsoleView.viewMenu()
        default:
            print("Invalid input")
        }
        
        displayHomeOptions()
    }
}

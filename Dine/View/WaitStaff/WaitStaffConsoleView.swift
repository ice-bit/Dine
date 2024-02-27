//
//  WaitStaffConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 27/02/24.
//

import Foundation

struct WaitStaffConsoleView {
    private let account: Account
    
    private let restaurant = RestaurantManager.shared.restaurant
    
    
    init(account: Account) {
        self.account = account
    }
    
    func displayOptions() {
        print("1. Place Order")
        print("2. Generate Bill")
        print("3. Update Order Status")
        print("4. View Bills")
        print("5. View Orders")
        print("6. View Menu")
        print("7. Account")
        print("0. Quit")
        handleOptions()
    }
    
    private func handleOptions() {
        let choice = readLine() ?? ""
        switch choice {
        case "1": // Place order
            let orderConsoleView = OrderConsoleView(restaurant: restaurant)
            orderConsoleView.promptMenuItemsSelection()
        case "2": // Generate bill
            let billConsoleView = BillingConsoleView()
            billConsoleView.generatebill()
        case "3": // Update order status
            let updateConsoleView = UpdateStatusConsoleView()
            updateConsoleView.manageReceivedOrders()
        case "4": // View bills
            let billConsoleView = BillingConsoleView()
            billConsoleView.displayBills()
        case "5": // View Orders
            let orderConsoleView = OrderConsoleView(restaurant: restaurant)
            orderConsoleView.viewOrders()
        case "6": // View menu
            let menuConsoleView = MenuConsoleView(menu: restaurant.menu)
            menuConsoleView.viewMenu()
        case "7": // Account
            print("Yet to implement")
        case "0": // Quit
            exit(0)
        default:
            print("Invalid input! Try again")
            handleOptions()
        }
    }
}

//
//  ManagerConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 27/02/24.
//

import Foundation

struct ManagerConsoleView {
    private let account: Account
    
    init(account: Account) {
        self.account = account
    }
    
    func displayManagerOptions() {
        print("1. Generate Bill")
        print("2. Customize Table")
        print("3. Customize Menu")
        print("4. View Bills")
        print("5. View Orders")
        print("6. View Menu")
        print("7. View Tables")
        print("8. Account")
        print("9. Quit")
        handleOption()
    }
    
    private func handleOption() {
        let restaurantDataManager = RestaurantDataManager()
        guard let restaurant = restaurantDataManager.getRestaurant() else {
            print("No restaurant found")
            return
        }
        
        let choice = readLine() ?? ""
        switch choice {
        case "1": // Generate bill
            let billConsoleView = BillingConsoleView()
            billConsoleView.generatebill()
        case "2": // Customize table
            let tableConsoleView = TableConsoleView()
            tableConsoleView.displayOptions()
        case "3": // Customize menu
            let menuConsoleView = MenuConsoleView()
            menuConsoleView.displayAndHandleMenuOptions()
        case "4": // View bill
            let billConsoleView = BillingConsoleView()
            billConsoleView.displayBills()
        case "5": // View orders
            let orderConsoleView = OrderConsoleView(restaurant: restaurant)
            orderConsoleView.viewOrders()
        case "6": // View menu
            let menuConsoleView = MenuConsoleView()
            menuConsoleView.viewMenu()
        case "7": // View tables
            print("Yet to implement")
        case "8": // Account
            let accountConsoleView = AccountConsoleView()
            accountConsoleView.displayAccountOptions()
            return
        case "9": // Quit
            exit(0)
        default:
            print("Invalid input")
            handleOption()
        }
    }
}

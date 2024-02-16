//
//  HomeConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 25/01/24.
//

import Foundation

class HomeConsoleView {
    private let restaurant: Restaurant
    private let userRepository: UserRepository
    
    private let orderManager = OrderManager()
    private let tableManager = TableManager()
    private let billManager = BillManager()
    
    weak var delegate: LoginStateDelegate?
    
    init(restaurant: Restaurant, userRepository: UserRepository) {
        self.restaurant = restaurant
        self.userRepository = userRepository
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
        print("8. Add Employee")
        print("9. Customize Table")
        print("10. Sign Out")
        print("0. Quit")
        handleHomeOptions()
    }
    
    private func handleHomeOptions() {
        let choice = readLine() ?? ""
        switch choice {
        case "1": // Home
            let orderConsoleView = OrderConsoleView(restaurant: restaurant, orderManager: orderManager, tableManager: tableManager)
            orderConsoleView.promptMenuItemsSelection()
        case "2": // Customize menu
            let menuConsoleView = MenuConsoleView(menu: restaurant.menu)
            menuConsoleView.displayAndHandleMenuOptions()
        case "3": // Generate bill
            let billConsoleView = BillingConsoleView(billManager: billManager, orderManager: orderManager)
            billConsoleView.generatebill()
        case "4": // Update order status
            let chefConsoleView = ChefConsoleView(orderManager: orderManager)
            chefConsoleView.manageReceivedOrders()
        case "5": // View bills
            let billConsoleView = BillingConsoleView(billManager: billManager, orderManager: orderManager)
            billConsoleView.viewBill()
        case "6": // View orders
            let orderConsoleView = OrderConsoleView(restaurant: restaurant, orderManager: orderManager, tableManager: tableManager)
            orderConsoleView.viewOrders()
        case "7": // View menu
            let menuConsoleView = MenuConsoleView(menu: restaurant.menu)
            menuConsoleView.viewMenu()
        case "8": // Add employee
            let authConsoleView = AuthConsoleView(userRepository: userRepository)
            authConsoleView.createEmployee()
        case "9": // Customize Table
            let tableConsoleView = TableConsoleView(tableManager: tableManager)
            tableConsoleView.displayOptions()
        case "10": // Sign Out
            //UserStatus.userLoggedIn.updateStatus(false)
            delegate?.isUserLoggedIn(false)
            return
        case "0":
            exit(0)
        default:
            print("Invalid input")
        }
        
        displayHomeOptions()
    }
}

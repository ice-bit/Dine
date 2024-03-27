//
//  ManagerConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 27/02/24.
//

import Foundation
import NotificationCenter

struct ManagerConsoleView {
    private let account: Account
    init(account: Account) {
        self.account = account
    }
    let createDatabaseConnection: () throws -> DatabaseAccess? = {
        return try SQLiteDataAccess.openDatabase()
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
        print("0. Sign Out")
        handleOption()
    }
    
    private func handleOption() {
        guard let databaseAccess = try? createDatabaseConnection() else {
            print("Connection failed")
            return
        }
        // TODO: Give proper retaurant query
        let fetchRestaurantQuery = "SELECT * FROM \(DatabaseTables.restaurantDBTable.rawValue);"
        guard let restaurant = try? databaseAccess.retrieve(query: fetchRestaurantQuery, parseRow: Restaurant.parseRow).first as? Restaurant else {
            print("No restaurant found")
            // TODO: Route to create restaurant screen
            return
        }
        
        let choice = readLine() ?? ""
        switch choice {
        case "1": // Generate bill
            let orderService = OrderServiceImpl(databaseAccess: databaseAccess)
            let billService = BillServiceImpl(databaseAccess: databaseAccess)
            let billController = BillingController(billService: billService, orderService: orderService)
            let billConsoleView = BillingConsoleView(billController: billController)
            billConsoleView.generatebill()
        case "2": // Customize table
            let tableService = TableServiceImpl(databaseAccess: databaseAccess)
            let tableController = TableController(tableService: tableService)
            let tableConsoleView = TableConsoleView(tableService: tableController)
            tableConsoleView.displayOptions()
        case "3": // Customize menu
            let menuService = MenuServiceImpl(databaseAccess: databaseAccess)
            let menuController = MenuController(menuService: menuService)
            let menuConsoleView = MenuConsoleView(menuController: menuController)
            menuConsoleView.displayAndHandleMenuOptions()
        case "4": // View bill
            let orderService = OrderServiceImpl(databaseAccess: databaseAccess)
            let billService = BillServiceImpl(databaseAccess: databaseAccess)
            let billController = BillingController(billService: billService, orderService: orderService)
            let billConsoleView = BillingConsoleView(billController: billController)
            billConsoleView.displayBills()
        case "5": // View orders
            let orderService = OrderServiceImpl(databaseAccess: databaseAccess)
            let tableService = TableServiceImpl(databaseAccess: databaseAccess)
            let tableController = TableController(tableService: tableService)
            let orderController = OrderController(orderService: orderService, tableService: tableService)
            let menuService = MenuServiceImpl(databaseAccess: databaseAccess)
            let menuController = MenuController(menuService: menuService)
            let orderConsoleView = OrderConsoleView(restaurant: restaurant, menuController: menuController, orderService: orderController, tableService: tableController)
            orderConsoleView.viewOrders()
            
        case "6": // View menu
            let menuService = MenuServiceImpl(databaseAccess: databaseAccess)
            let menuController = MenuController(menuService: menuService)
            let menuConsoleView = MenuConsoleView(menuController: menuController)
            menuConsoleView.viewMenu()
        case "7": // View tables
            let tableService = TableServiceImpl(databaseAccess: databaseAccess)
            let tableController = TableController(tableService: tableService)
            let tableConsoleView = TableConsoleView(tableService: tableController)
            tableConsoleView.viewTables()
        case "8": // Account
            let accountConsoleView = AccountConsoleView()
            accountConsoleView.displayAccountOptions()
            return
        case "0": // Quit
            UserStore.removeCurrentUser()
            NotificationCenter.default.post(name: .applicationModeDidChanged, object: nil, userInfo: ["newMode": ApplicationMode.signedOut])
            return
        default:
            print("Invalid input")
            handleOption()
        }
    }
}

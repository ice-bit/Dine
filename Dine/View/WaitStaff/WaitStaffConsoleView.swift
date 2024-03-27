//
//  WaitStaffConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 27/02/24.
//

import Foundation
import NotificationCenter

struct WaitStaffConsoleView {
    private let account: Account
    weak var applicationModeDelegate: ApplicationModeDelegate?
    init(account: Account) {
        self.account = account
    }
    let createDatabaseConnection: () throws -> DatabaseAccess? = {
        return try SQLiteDataAccess.openDatabase()
    }
    func displayOptions() {
        print("1. Place Order")
        print("2. Generate Bill")
        print("3. Update Order Status")
        print("4. View Bills")
        print("5. View Orders")
        print("6. View Menu")
        print("7. Account")
        print("0. Sign Out")
        handleOptions()
    }
    
    private func handleOptions() {
        guard let databaseAccess = try? createDatabaseConnection() else {
            print("Database connection failed")
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
        case "1": // Place order
            let menuService = MenuServiceImpl(databaseAccess: databaseAccess)
            let menuController = MenuController(menuService: menuService)
            let orderService = OrderServiceImpl(databaseAccess: databaseAccess)
            let tableService = TableServiceImpl(databaseAccess: databaseAccess)
            let orderController = OrderController(orderService: orderService, tableService: tableService)
            let tableController = TableController(tableService: tableService)
            let orderConsoleView = OrderConsoleView(restaurant: restaurant, menuController: menuController, orderService: orderController, tableService: tableController)
            orderConsoleView.promptMenuItemsSelection()
        case "2": // Generate bill
            let orderService = OrderServiceImpl(databaseAccess: databaseAccess)
            let billService = BillServiceImpl(databaseAccess: databaseAccess)
            let billController = BillingController(billService: billService, orderService: orderService)
            let billConsoleView = BillingConsoleView(billController: billController)
            billConsoleView.generatebill()
        case "3": // Update order status
            let orderService = OrderServiceImpl(databaseAccess: databaseAccess)
            let updateController = UpdateStatusController(orderService: orderService)
            let updateConsoleView = UpdateStatusConsoleView(updateStatusService: updateController)
            do {
                try updateConsoleView.manageReceivedOrders()
            } catch {
                print(error)
            }
        case "4": // View bills
            let orderService = OrderServiceImpl(databaseAccess: databaseAccess)
            let billService = BillServiceImpl(databaseAccess: databaseAccess)
            let billController = BillingController(billService: billService, orderService: orderService)
            let billConsoleView = BillingConsoleView(billController: billController)
            billConsoleView.displayBills()
        case "5": // View Orders
            let menuService = MenuServiceImpl(databaseAccess: databaseAccess)
            let menuController = MenuController(menuService: menuService)
            let orderService = OrderServiceImpl(databaseAccess: databaseAccess)
            let tableService = TableServiceImpl(databaseAccess: databaseAccess)
            let orderController = OrderController(orderService: orderService, tableService: tableService)
            let tableController = TableController(tableService: tableService)
            let orderConsoleView = OrderConsoleView(restaurant: restaurant, menuController: menuController, orderService: orderController, tableService: tableController)
            orderConsoleView.viewOrders()
        case "6": // View menu
            let menuService = MenuServiceImpl(databaseAccess: databaseAccess)
            let menuController = MenuController(menuService: menuService)
            let menuConsoleView = MenuConsoleView(menuController: menuController)
            menuConsoleView.viewMenu()
        case "7": // Account
            let accountConsoleView = AccountConsoleView()
            accountConsoleView.displayAccountOptions()
            return
        case "0": // Sign Out
            UserStore.removeCurrentUser()
            NotificationCenter.default.post(name: .applicationModeDidChanged, object: nil, userInfo: ["newMode": ApplicationMode.signedOut])
            return
        default:
            print("Invalid input! Try again")
            handleOptions()
        }
    }
}

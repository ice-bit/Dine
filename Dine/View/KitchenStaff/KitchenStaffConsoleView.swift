//
//  KitchenStaffConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 27/02/24.
//

import Foundation
import NotificationCenter

struct KitchenStaffConsoleView {
    private let account: Account
    init(account: Account) {
        self.account = account
    }
    let createDatabaseConnection: () throws -> DatabaseAccess? = {
        return try SQLiteDataAccess.openDatabase()
    }
    
    func displayOptions() {
        print("1. Update Order")
        print("2. Account")
        print("3. Sign Out")
        handleOptions()
    }
    
    private func handleOptions() {
        guard let databaseAccess = try? createDatabaseConnection() else {
            print("Connection failed")
            return
        }
        let choice = readLine() ?? ""
        switch choice {
        case "1": // Update order status
            let orderService = OrderServiceImpl(databaseAccess: databaseAccess)
            let updateController = UpdateStatusController(orderService: orderService)
            let updateConsoleView = UpdateStatusConsoleView(updateStatusService: updateController)
            do {
                try updateConsoleView.manageReceivedOrders()
            } catch {
                print(error)
            }
        case "2": // Account
            let accountConsoleView = AccountConsoleView()
            accountConsoleView.displayAccountOptions()
            return
        case "3": // Quit
            UserStore.removeCurrentUser()
            NotificationCenter.default.post(name: .applicationModeDidChanged, object: nil, userInfo: ["newMode": ApplicationMode.signedOut])
            return
        default:
            print("Invalid input! Try again")
            handleOptions()
        }
    }
}

//
//  KitchenStaffConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 27/02/24.
//

import Foundation

struct KitchenStaffConsoleView {
    private let account: Account
    
    init(account: Account) {
        self.account = account
    }
    
    func displayOptions() {
        print("1. Update Order")
        print("2. Account")
        print("3. Quit")
        handleOptions()
    }
    
    private func handleOptions() {
        let choice = readLine() ?? ""
        switch choice {
        case "1": // Update order status
            let updateConsoleView = UpdateStatusConsoleView()
            updateConsoleView.manageReceivedOrders()
        case "2": // Account
            let accountConsoleView = AccountConsoleView()
            accountConsoleView.displayAccountOptions()
            return
        case "3": // Quit
            exit(0)
        default:
            print("Invalid input! Try again")
            handleOptions()
        }
    }
}

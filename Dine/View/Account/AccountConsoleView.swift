//
//  AccountConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 01/03/24.
//

import Foundation

struct AccountConsoleView {
    private let account = UserStore().getCurrentUser()
    
    func displayAccountOptions() {
        if let account = account {
            print("Welcome \(account.username)")
        }
        print("1. Change username")
        print("2. Change password")
        print("3. Sign out")
        handleAccountOptions()
    }
    
    private func handleAccountOptions() {
        let choice = readLine() ?? ""
        switch choice {
        case "1":
            print()
        case "2":
            print()
        case "3":
            UserStatus.userLoggedIn.updateStatus(false)
            print("Logged out!")
        default:
            print("Invalid input! Try again")
            handleAccountOptions()
        }
    }
}

//
//  AccountConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 01/03/24.
//

import Foundation

struct AccountConsoleView {
    func displayAccountOptions() {
        if let account = UserStore.getCurrentUser() {
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
            UserStore.removeCurrentUser()
            exit(0)
        default:
            print("Invalid input! Try again")
            handleAccountOptions()
        }
    }
}

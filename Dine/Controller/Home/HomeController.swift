//
//  HomeController.swift
//  Dine
//
//  Created by doss-zstch1212 on 10/01/24.
//

import Foundation

class HomeController {
    private func takeOrder() {
        print(#function)
    }
    
    private func viewOrderHistory() {
        print(#function)
    }
    
    private func viewMenu() {
        print(#function)
    }
    
    private func editMenu() {
        print(#function)
    }
    
    func run() {
        print("1. Take Order\n2. View Menu\n3. View History\n4. Edit Menu\n5. Exit")
        let homeConsoleView = HomeConsoleView()
        let choice = homeConsoleView.getInput()
        switch choice {
        case "1":
            takeOrder()
        case "2":
            viewMenu()
        case "3":
            viewOrderHistory()
        case "4":
            editMenu()
        case "5":
            exit(0)
        default:
            homeConsoleView.show(message: "Invalid choice. Please try again.")
        }
    }
}

extension HomeController: AuthStateObserver {
    func didLogin(userId: String) {
        run()
    }
    
    func didLogout() {
        exit(0)
    }
}

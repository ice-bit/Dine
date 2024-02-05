//
//  SetupConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 23/01/24.
//

import Foundation

struct SetupConsoleView {
    func promptAdminSetup() {
        print("Create administrator.")
        print("Enter admin username:")
        let adminUsername = readLine() ?? ""
        print("Create new password:")
        let password = readLine() ?? ""
        
        let authController = AuthController()
        if authController.createAccount(username: adminUsername, password: password, userRole: .admin) {
            displaySetupOption()
        } else {
            // TODO: handle exit case
        }
    }
    
    func displaySetupOption() {
        print("Start setting your Restaurant?")
        print("1. Yes")
        print("2. No")
        handleSetupSelection()
    }
    
    func startSetup() {
        promptAdminSetup()
    }
    
    func promptRestaurantSetup() {
        print("Enter restaurant details.")
        print("Enter restaurant name: ")
        let restaurantName = readLine() ?? ""
        print("Enter initial branch name:")
        let branchName = readLine() ?? ""
        print("Enter the location:")
        let location = readLine() ?? ""
        
        let restaurantController = RestaurantController()
        /*restaurantController.createRestaurant(name: restaurantName, branchName: branchName, location: location)*/
    }
    
    func handleSetupSelection() {
        let choice = readLine()
        switch choice {
        case "1":
            promptRestaurantSetup()
        case "2":
            exit(0)
        default:
            print("Invalid input")
            handleSetupSelection()
        }
    }
}

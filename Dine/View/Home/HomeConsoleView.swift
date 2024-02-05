//
//  HomeConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 25/01/24.
//

import Foundation

class HomeConsoleView {
    private let branch: Branch
    
    init(branch: Branch) {
        self.branch = branch
    }
    
    func displayHomeOptions() {
        print("Home")
        print("1. Place Order")
        print("2. Customize Menu")
        print("3. Generate Bill")
        print("4. Update Order Status")
        handleHomeOptions()
    }
    
    func displayEditMenuOptions() {
        print("Edit menu")
        print("1. Add food item")
        print("2. Remove item")
        handleEditMenuOptions()
    }
    
    func promptFoodItem() {
        print("Enter food item name:")
        let name = readLine() ?? ""
        print("Enter price:")
        let strPrice = readLine()
        guard let unwrappedStrPrice = strPrice else {
            print("Failed to unwrap - \(#function)")
            return
        }
        
        guard let price = Double(unwrappedStrPrice) else {
            print("Failed to convert string to double - \(#function)")
            return
        }
        
        let menuController = MenuController(branch: branch)
        menuController.addItemToMenu(name: name, price: price)
        FileIOService.saveDataToFile(data: branch, fileName: "\(branch)")
    }
    
    func handleEditMenuOptions() {
        let choice = readLine() ?? ""
        switch choice {
        case "1":
            promptFoodItem()
        case "2":
            print()
        default:
            print("Invalid input")
        }
    }
    
    func handleHomeOptions() {
        let choice = readLine() ?? ""
        switch choice {
        case "1":
            let orderConsoleView = OrderConsoleView(branch: branch)
            orderConsoleView.displayMenu()
        case "2":
            displayEditMenuOptions()
        case "3":
            let billConsoleView = BillingConsoleView(branch: branch)
            billConsoleView.generatebill()
        case "4":
            print()
            
        default:
            print("Invalid input")
        }
        
        displayHomeOptions()
    }
}

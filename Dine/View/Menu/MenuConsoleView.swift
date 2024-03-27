//
//  MenuConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 06/02/24.
//

import Foundation

class MenuConsoleView {
    private let menuController: MenuController
    init(menuController: MenuController) {
        self.menuController = menuController
    }
    func displayAndHandleMenuOptions() {
        print("Edit Menu")
        print("1. Add Item")
        print("2. Remove Item")
        print("3. Edit Price")
        print("4. Edit Name")
        print("0. Go Back")
        let choice = readLine()
        switch choice {
        case "1":
            promptFoodItem()
        case "2":
            promptRemovalOfItem()
        case "3":
            if let menuItem = displayMenuItemsAndChoose() {
                if let price = getPriceInput() {
                    menuController.editPrice(menuItem, price: price)
                }
            }
        case "4":
            if let menuItem = displayMenuItemsAndChoose() {
                if let name = getNameInput() {
                    menuController.editName(menuItem, name: name)
                }
            }
        case "0":
            return
        default:
            print("Invalid choice")
        }
        
        displayAndHandleMenuOptions()
    }
    
    private func displayMenuItemsAndChoose() -> MenuItem? {
        guard let menuItems = menuController.getMenuItems() else {
            print("No menuItem found!")
            return nil
        }
        
        for (index, item) in menuItems.enumerated() {
            print("\(index + 1). \(item.name) - $\(item.price)")
        }
        
        print("Enter the item number to select (0 to finish):")
        if let choice = readLine(), let itemNumber = Int(choice), itemNumber >= 1, itemNumber <= menuItems.count {
            let chosenItem = menuItems[itemNumber - 1]
            print("You chose item \(chosenItem.itemId)")
            return chosenItem
        } else {
            print("Invalid choice or cancelled.")
            return nil
        }
    }
    
    private func getPriceInput() -> Double? {
        print("Enter the price to be updated:")
        if let inputPrice = readLine(), let price = Double(inputPrice) {
            return price
        } else {
            return nil
        }
    }
    
    private func getNameInput() -> String? {
        print("Enter the name to be updated:")
        if let inputName = readLine() {
            return inputName
        } else {
            return nil
        }
    }
    
    private func promptFoodItem()  {
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
        do {
            try menuController.addItemToMenu(name: name, price: price)
        } catch {
            print(error)
        }
    }
    
    private func promptRemovalOfItem() {
        if let menuItem = displayMenuItemsAndChoose() {
            do {
                try menuController.removeItemFromMenu(menuItem)
            } catch {
                print(error)
            }
        }
    }
    
    func viewMenu() {
        guard let menuItems = menuController.getMenuItems() else {
            print("No menuItem found!")
            return 
        }
        
        for (index, item) in menuItems.enumerated() {
            print("\(index + 1). \(item.name) - $\(item.price)")
        }
    }
}

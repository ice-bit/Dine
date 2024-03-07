//
//  MenuConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 06/02/24.
//

import Foundation

class MenuConsoleView {
    private let menu = Menu.shared
    
    init() {
        loadMenu()
    }
    
    func loadMenu() {
        menu.loadMenu()
    }
    
    func displayAndHandleMenuOptions() {
        print("Edit Menu")
        print("1. Add Item")
        print("2. Remove Item")
        print("3. Edit Price")
        print("4. Edit Name")
        print("0. Go Back")
        
        let menuController = MenuController(menu: menu)
        
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
        let menuController = MenuController(menu: menu)
        menuController.displayMenuItems()
        
        print("Enter the item number to select (0 to finish):")
        if let choice = readLine(), let itemNumber = Int(choice), itemNumber >= 1, itemNumber <= menu.itemsCount {
            let chosenItem = menu.menuItems[itemNumber - 1]
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
        
        let menuContoller = MenuController(menu: menu)
        menuContoller.addItemToMenu(name: name, price: price)
    }
    
    private func promptRemovalOfItem() {
        if let menuItem = displayMenuItemsAndChoose() {
            let menuController = MenuController(menu: menu)
            menuController.removeItemFromMenu(menuItem)
        }
    }
    
    func viewMenu() {
        let menuController = MenuController(menu: menu)
        menuController.displayMenuItems()
    }
}

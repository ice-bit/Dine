//
//  Branch.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Branch: Codable {
    private var branchName: String
    private var location: String
    private var kitchen: Kitchen
    private var menu: Menu
    
    init(branchName: String, location: String, kitchen: Kitchen, menu: Menu) {
        self.branchName = branchName
        self.location = location
        self.kitchen = kitchen
        self.menu = menu
    }
    
    func menuItemsCount() -> Int {
        return menu.itemsCount()
    }
    
    func getMenuItem(at index: Int) -> MenuItem {
        return menu[index]
    }
    
    // Method to add an item to the menu
    func addItemToMenu(_ item: MenuItem) {
        menu.addItem(item)
    }
    
    // Method to remove an item from the menu
    func removeItemFromMenu(_ item: MenuItem) {
        menu.removeItem(item)
    }
    
    func displayMenu() {
        menu.displayMenu()
    }
}

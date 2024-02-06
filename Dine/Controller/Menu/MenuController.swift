//
//  MenuController.swift
//  Dine
//
//  Created by doss-zstch1212 on 24/01/24.
//

import Foundation

class MenuController {
    private var menu: Menu
    
    init(menu: Menu) {
        self.menu = menu
    }
    
    func addItemToMenu(name: String, price: Double) {
        let menuItem = MenuItem(name: name, price: price)
        menu.addItem(menuItem)
    }
    
    func removeItemFromMenu(_ menuItem: MenuItem) {
        menu.removeItem(menuItem)
    }
    
    func editPrice(_ menuItem: MenuItem, price: Double) {
        if let index = menu.menuItems.firstIndex(where: { $0.itemId == menuItem.itemId }) {
            menu.menuItems[index].price = price
        } else {
            print("Item not found!")
        }
    }
    
    func editName(_ menuItem: MenuItem, name: String) {
        if let index = menu.menuItems.firstIndex(where: { $0.itemId == menuItem.itemId }) {
            menu.menuItems[index].name = name
        } else {
            print("Item not found!")
        }
    }
    
    func displayMenuItems() {
        for (index, item) in menu.menuItems.enumerated() {
            print("\(index + 1). \(item.name) - $\(item.price)")
        }
    }
}

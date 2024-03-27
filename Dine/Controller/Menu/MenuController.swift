//
//  MenuController.swift
//  Dine
//
//  Created by doss-zstch1212 on 24/01/24.
//

import Foundation

class MenuController {
    private let menuService: MenuService
    init(menuService: MenuService) {
        self.menuService = menuService
    }
    
    func addItemToMenu(name: String, price: Double) throws {
        let menuItem = MenuItem(name: name, price: price)
        try menuService.add(menuItem)
    }
    
    func removeItemFromMenu(_ menuItem: MenuItem) throws {
        try menuService.delete(menuItem)
    }
    
    func itemsCount() -> Int? {
        do {
            guard let results = try menuService.fetch() else { return nil }
            return results.count
        } catch {
            print(error)
        }
        return nil
    }
    
    func getMenuItems() -> [MenuItem]? {
        do {
            guard let results = try menuService.fetch() else { return nil }
            return results
        } catch {
            print("Failed to load MenuItems!")
        }
        return nil
    }
    
    private func fetchMenuitem(_ menuItemID: UUID) -> MenuItem? {
        guard let resultItems = try? menuService.fetch() else { return nil }
        guard let itemIndex = resultItems.firstIndex(where: { $0.itemId == menuItemID }) else { return nil }
        return resultItems[itemIndex]
    }
    
    func editPrice(_ menuItem: MenuItem, price: Double) {
        guard let item = fetchMenuitem(menuItem.itemId) else {
            print("No items found user the UUID: \(menuItem.itemId) & Name: \(menuItem.name)!")
            return
        }
        item.price = price
        do {
            try menuService.update(item)
        } catch {
            print("Failed to update price!")
        }
    }
    
    func editName(_ menuItem: MenuItem, name: String) {
        guard let item = fetchMenuitem(menuItem.itemId) else {
            print("No items found user the UUID: \(menuItem.itemId) & Name: \(menuItem.name)!")
            return
        }
        item.name = name
        do {
            try menuService.update(item)
        } catch {
            print("Failed to update price!")
        }
    }
    
    func fetchMenuItems() -> [MenuItem]? {
        guard let resultItems = try? menuService.fetch() else { return nil }
        return resultItems
    }
}

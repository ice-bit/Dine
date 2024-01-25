//
//  Menu.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Menu: Codable {
    private var items: [MenuItem]
    
    /// Creates an instance of `Menu` with empty array of `MenuItem`.
    convenience init() {
        self.init(items: [])
    }
    
    init(items: [MenuItem]) {
        self.items = items
    }
    
    subscript(index: Int) -> MenuItem {
        get {
            return items[index]
        }
    }
    
    func displayMenu() {
        for (index, item) in items.enumerated() {
            print("\(index + 1). \(item.name) - $\(item.price)")
        }
    }
    
    func itemsCount() -> Int {
        return items.count
    }
    
    func addItem(_ item: MenuItem) {
        items.append(item)
    }
    
    func removeItem(_ item: MenuItem) {
        if let indexToRemove = items.firstIndex(where: { $0.itemId == item.itemId }) {
            items.remove(at: indexToRemove)
            print("\(item.name) removed from the menu.")
        } else {
            print("\(item.name) not found in the menu.")
        }
    }
}

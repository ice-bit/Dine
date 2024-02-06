//
//  Menu.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Menu: Codable {
    private var _items: [MenuItem]
    
    var itemsCount: Int {
        return _items.count
    }
    
    var menuItems: [MenuItem] {
        return _items
    }
    
    /// Creates an instance of `Menu` with empty array of `MenuItem`.
    convenience init() {
        self.init(items: [])
    }
    
    init(items: [MenuItem]) {
        self._items = items
    }
    
    subscript(index: Int) -> MenuItem {
        return _items[index]
    }
    
    func displayMenuItems() {
        for (index, item) in _items.enumerated() {
            print("\(index + 1). \(item.name) - $\(item.price)")
        }
    }
    
    func addItem(_ item: MenuItem) {
        _items.append(item)
    }
    
    func removeItem(_ item: MenuItem) {
        if let indexToRemove = _items.firstIndex(where: { $0.itemId == item.itemId }) {
            _items.remove(at: indexToRemove)
            print("\(item.name) removed from the menu.")
        } else {
            print("\(item.name) not found in the menu.")
        }
    }
}

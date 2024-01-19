//
//  Menu.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Menu {
    /*private var menuId: Int
    private var title: String
    private var description: String
    private var menuSections: [MenuSection]
    
    init(menuId: Int, title: String, description: String, menuSections: [MenuSection]) {
        self.menuId = menuId
        self.title = title
        self.description = description
        self.menuSections = menuSections
    }
    
    func addMenuSection() {
        
    }*/
    
    var items: [MenuItem]
    
    init() {
        self.items = []
    }
    
    init(items: [MenuItem]) {
        self.items = items
    }
    
    func displayMenu() {
        for (index, item) in items.enumerated() {
            print("\(index + 1). \(item.name) - $\(item.price)")
        }
    }
}

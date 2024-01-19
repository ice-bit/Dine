//
//  MenuSection.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class MenuSection {
    private var menuSectionId: UUID
    private var title: String
    private var description: String
    private var menuItems: [MenuItem]
    
    init(menuSectionId: UUID, title: String, description: String, menuItems: [MenuItem]) {
        self.menuSectionId = menuSectionId
        self.title = title
        self.description = description
        self.menuItems = menuItems
    }
    
    func addMenuItem(title: String, description: String, price: Double) {
//        let menuItem = MenuItem(menuItemId: UUID(), title: title, description: description, price: price)
//        menuItems.append(menuItem)
    }
}

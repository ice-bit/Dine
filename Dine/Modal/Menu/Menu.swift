//
//  Menu.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Menu {
    private var menuId: Int
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
        
    }
}

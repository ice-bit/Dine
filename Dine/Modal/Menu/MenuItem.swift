//
//  MenuItem.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class MenuItem {
    /*private var menuItemId: UUID
    private var title: String
    private var description: String
    private var price: Double
    
    init(menuItemId: UUID, title: String, description: String, price: Double) {
        self.menuItemId = menuItemId
        self.title = title
        self.description = description
        self.price = price
    }
    
    func updatePrice(title: String, description: String) {
        
    }*/

    let itemId = UUID()
    let name: String
    let price: Double
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
}

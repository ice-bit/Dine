//
//  MenuItem.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class MenuItem {
    private var menuItemId: Int
    private var title: String
    private var description: String
    private var price: Double
    
    init(menuItemId: Int, title: String, description: String, price: Double) {
        self.menuItemId = menuItemId
        self.title = title
        self.description = description
        self.price = price
    }
}

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
    
    init(menuId: Int, title: String, description: String) {
        self.menuId = menuId
        self.title = title
        self.description = description
    }
}

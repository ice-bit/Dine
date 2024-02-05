//
//  MenuController.swift
//  Dine
//
//  Created by doss-zstch1212 on 24/01/24.
//

import Foundation

class MenuController {
    private var branch: Branch
    
    init(branch: Branch) {
        self.branch = branch
    }
    
    func addItemToMenu(name: String, price: Double) {
        let menuItem = MenuItem(name: name, price: price)
        branch.addItemToMenu(menuItem)
    }
    
    func removeItemFromMenu() {
        // TODO: Still figuring out..!
    }
}

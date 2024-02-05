//
//  MenuItem.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class MenuItem: Codable {
    let itemId: UUID
    let name: String
    let price: Double
    
    init(name: String, price: Double) {
        self.itemId = UUID()
        self.name = name
        self.price = price
    }
}

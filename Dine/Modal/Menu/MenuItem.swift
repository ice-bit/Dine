//
//  MenuItem.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class MenuItem: Codable {
    let itemId: UUID
    var name: String
    var price: Double
    
    /// Returns CSV string without header.
    var csvString: String {
        "\(itemId),\(name),\(price)"
    }
    
    init(itemId: UUID, name: String, price: Double) {
        self.itemId = itemId
        self.name = name
        self.price = price
    }
    
    convenience init(name: String, price: Double) {
        self.init(itemId: UUID(), name: name, price: price)
    }
}

extension MenuItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(itemId)
    }
    
    static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.itemId == rhs.itemId
    }
}

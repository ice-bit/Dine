//
//  Restaurant.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Restaurant: Codable {
    private var name: String
    private var restaurantId: UUID
    private var location: String
    
    init(name: String, location: String) {
        self.name = name
        self.restaurantId = UUID()
        self.location = location
    }
}

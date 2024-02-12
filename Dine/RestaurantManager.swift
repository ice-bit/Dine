//
//  RestaurantManager.swift
//  Dine
//
//  Created by doss-zstch1212 on 08/02/24.
//

import Foundation

class RestaurantManager {
//    private var restaurant: Restaurant?
    
    private var restaurant = Restaurant(name: "Hola", location: "London, UK", menu: Menu(items: [MenuItem(name: "Apple", price: 549), MenuItem(name: "TestItem1", price: 499), MenuItem(name: "TestItem2", price: 249),]))
    
    func setRestaurant(_ restaurant: Restaurant) {
        guard self.restaurant == nil else { return }
        
        self.restaurant = restaurant
    }
    
    func getRestaurant() -> Restaurant? {
        return restaurant
    }
}

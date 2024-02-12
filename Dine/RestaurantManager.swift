//
//  RestaurantManager.swift
//  Dine
//
//  Created by doss-zstch1212 on 08/02/24.
//

import Foundation

class RestaurantManager {
    private var restaurant: Restaurant?
    
    func setRestaurant(_ restaurant: Restaurant) {
        guard self.restaurant == nil else { return }
        
        self.restaurant = restaurant
    }
    
    func getRestaurant() -> Restaurant? {
        return restaurant
    }
}

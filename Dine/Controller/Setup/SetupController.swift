//
//  SetupController.swift
//  Dine
//
//  Created by doss-zstch1212 on 08/02/24.
//

import Foundation

class SetupController {
    let restaurantManager: RestaurantManager
    
    init(restaurantManager: RestaurantManager) {
        self.restaurantManager = restaurantManager
    }
    
    func createRestaurant(name: String, locationName: String) {
        let restaurant = Restaurant(name: name, location: locationName)
        restaurantManager.setRestaurant(restaurant)
        // Restaurnat setup finished
        UserStatus.restaurantSetup.updateStatus(true)
    }
}


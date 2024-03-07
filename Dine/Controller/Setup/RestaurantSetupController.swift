//
//  SetupController.swift
//  Dine
//
//  Created by doss-zstch1212 on 08/02/24.
//

import Foundation

class RestaurantSetupController {
    let restaurantManager = RestaurantManager.shared
    
    func createRestaurant(name: String, locationName: String) -> Bool {
        let restaurant = Restaurant(name: name, location: locationName)
        restaurantManager.restaurant = restaurant
        // Restaurnat setup finished
        UserStatus.restaurantExists.updateStatus(true)
        return true
    }
}


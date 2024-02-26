//
//  SetupController.swift
//  Dine
//
//  Created by doss-zstch1212 on 08/02/24.
//

import Foundation

class SetupController {
    let restaurantManager = RestaurantManager.shared
    
    func createRestaurant(name: String, locationName: String) -> Bool {
        let restaurant = Restaurant(name: name, location: locationName)
        //restaurantManager.setRestaurant(restaurant)
        // Restaurnat setup finished
        //UserStatus.restaurantSetup.updateStatus(true)
        return true
    }
}


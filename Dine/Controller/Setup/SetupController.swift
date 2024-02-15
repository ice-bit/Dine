//
//  SetupController.swift
//  Dine
//
//  Created by doss-zstch1212 on 08/02/24.
//

import Foundation

class SetupController {
    func createRestaurant(name: String, locationName: String) {
        let restaurant = Restaurant(name: name, location: locationName)
        // Save restaurant
        restaurant.saveRestaurant()
        // Restaurnat setup finished
        UserStatus.restaurantSetup.updateStatus(true)
    }
}


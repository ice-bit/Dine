//
//  SetupController.swift
//  Dine
//
//  Created by doss-zstch1212 on 08/02/24.
//

import Foundation

protocol RestaurantSetupProtocol {
    func createRestaurant(name: String, locationName: String) -> Bool
}

class RestaurantSetupController: RestaurantSetupProtocol {
    func createRestaurant(name: String, locationName: String) -> Bool {
        let restaurantDataManager = RestaurantDataManager()
        
        let restaurant = Restaurant(name: name, location: locationName)
        restaurantDataManager.setRestaurant(restaurant: restaurant)
        // Restaurnat setup finished
        UserStatus.restaurantExists.updateStatus(true)
        return true
    }
}


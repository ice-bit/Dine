//
//  RestaurantSetupController.swift
//  Dine
//
//  Created by doss-zstch1212 on 19/01/24.
//

import Foundation

struct RestaurantSetupController {
    func createRestaurant() {
        let restaurantConsoleView = RestaurantConsoleView()
        guard let restaurantName = restaurantConsoleView.prompt() else {
            print("Invalid input.")
            return
        }
        
        
    }
}

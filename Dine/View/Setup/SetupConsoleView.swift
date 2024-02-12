//
//  SetupConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 23/01/24.
//

import Foundation

class SetupConsoleView {
    private let restaurantManager: RestaurantManager
    
    init(restaurantManager: RestaurantManager) {
        self.restaurantManager = restaurantManager
    }
    
    func promptRestaurantSetup() {
        print("Enter restaurant name")
        let restaurantName = readLine() ?? ""
        
        /*if restaurantName.isEmpty {
            print("Enter a valid name")
            promptRestaurantSetup()
        }*/
        
        print("Enter location name:")
        let locationName = readLine() ?? ""
        
        /*if locationName.isEmpty {
            print("Enter a valid name")
            promptRestaurantSetup()
        }*/
        
        let setupController = SetupController(restaurantManager: restaurantManager)
        setupController.createRestaurant(name: restaurantName, locationName: locationName)
    }
}


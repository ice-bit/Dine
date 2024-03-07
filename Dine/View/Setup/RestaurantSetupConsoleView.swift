//
//  SetupConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 23/01/24.
//

import Foundation

class RestaurantSetupConsoleView {
    private let restaurantSetupProtocol: RestaurantSetupProtocol
    
    init(restaurantSetupProtocol: RestaurantSetupProtocol) {
        self.restaurantSetupProtocol = restaurantSetupProtocol
    }
    
    func promptRestaurantSetup() {
        print("Enter restaurant name")
        let restaurantName = readLine() ?? ""
        
        if restaurantName.isEmpty {
            print("Enter a valid name")
            promptRestaurantSetup()
        }
        
        print("Enter location name:")
        let locationName = readLine() ?? ""
        
        if locationName.isEmpty {
            print("Enter a valid name")
            promptRestaurantSetup()
        }
        
        if restaurantSetupProtocol.createRestaurant(name: restaurantName, locationName: locationName) {
            print("Created restaurant successfully")
        } else {
            print("Failed to create restaurant")
        }
    }
}


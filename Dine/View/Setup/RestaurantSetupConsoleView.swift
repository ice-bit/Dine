//
//  SetupConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 23/01/24.
//

import Foundation

class RestaurantSetupConsoleView {
    private let restaurantSetupProtocol: RestaurantSetupProtocol
    weak var applicationModeDelegate: ApplicationModeDelegate?
    init(restaurantSetupProtocol: RestaurantSetupProtocol) {
        self.restaurantSetupProtocol = restaurantSetupProtocol
    }
    
    func promptRestaurantSetup() -> Bool {
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
        
        do {
            try restaurantSetupProtocol.createRestaurant(name: restaurantName, locationName: locationName)
            print("Created restaurant successfully")
            return true
        } catch {
            print("Failed to create restaurant. Error: \(error)")
        }
        return false
    }
}


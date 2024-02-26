//
//  SetupConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 23/01/24.
//

import Foundation

/*protocol InitialSetupTogglable: AnyObject {
    func toggleInitialSetup()
}*/

class SetupConsoleView {
    //weak var delegate: InitialSetupTogglable?
    
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
        
        let setupController = SetupController()
        if setupController.createRestaurant(name: restaurantName, locationName: locationName) {
            //delegate?.toggleInitialSetup()
            print("Created restaurant successfully")
        } else {
            print("Failed to create restaurant")
        }
    }
}


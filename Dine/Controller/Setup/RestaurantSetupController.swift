//
//  SetupController.swift
//  Dine
//
//  Created by doss-zstch1212 on 08/02/24.
//

import Foundation

protocol RestaurantSetupProtocol {
    func createRestaurant(name: String, locationName: String) throws
}

class RestaurantSetupController: RestaurantSetupProtocol {
    private let databaseAccess: DatabaseAccess
    init(databaseAccess: DatabaseAccess) {
        self.databaseAccess = databaseAccess
    }
    
    func createRestaurant(name: String, locationName: String) throws {
        let restaurant = Restaurant(name: name, location: locationName)
        try databaseAccess.insert(restaurant)
    }
}


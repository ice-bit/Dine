//
//  RestaurantLoader.swift
//  Dine
//
//  Created by doss-zstch1212 on 28/02/24.
//

import Foundation

struct RestaurantDataManager {
    func getRestaurant() -> Restaurant? {
        if let restaurantData = UserDefaults.standard.data(forKey: UserDefaultsKeys.restaurantKey.rawValue),
           let restaurant = try? JSONDecoder().decode(Restaurant.self, from: restaurantData) {
            return restaurant
        }
        
        return nil
    }
    
    func setRestaurant(restaurant: Restaurant) {
        let restaurantData = try? JSONEncoder().encode(restaurant)
        UserDefaults.standard.set(restaurant, forKey: UserDefaultsKeys.restaurantKey.rawValue)
    }
    
    func removeRestaurnt() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.restaurantKey.rawValue)
    }
}

//
//  DatabaseTables.swift
//  Dine
//
//  Created by doss-zstch1212 on 20/03/24.
//

import Foundation

enum DatabaseTables: String, CaseIterable {
    case restaurantDBTable = "Restaurants"
    case accountTable = "Accounts"
    case billTable = "Bills"
    case restaurantTable = "Tables"
    case orderMenuItemTable = "OrderItems"
    case menuItem = "MenuItems"
    case orderTable = "OrderData"
}
//vs
/*struct DatabaseTables {
    static let accountTable = "accounts"
    static let orderTable = "Order"
    static let menuItem = "MenuItem"
    static let billTable = "BillItem"
    static let restaurantTable = "RestaurantTable"
}*/



//
//  CSVLoader.swift
//  Dine
//
//  Created by doss-zstch1212 on 13/02/24.
//

import Foundation

struct CSVLoader {
    /// Loads a restaurant object from a CSV file.
    ///
    /// - Parameter filePath: The path to the CSV file.
    /// - Returns: A `Restaurant` object containing the data from the CSV file,
    ///           or nil if the file is invalid, empty, or an error occurs.
    func loadRestaurants(filePath: String) throws -> Restaurant? {
        let csvData = try String(contentsOfFile: filePath)
        
        // Parse the CSV data
        let (restaurant, error) = try parseRestaurant(from: csvData)
        if let error = error {
            throw error
        } else {
            return restaurant
        }
    }
    
    /// Internal helper for parsing restaurant data from CSV.
    ///
    /// - Parameter csvData: The CSV data string.
    /// - Returns: A tuple containing the parsed `Restaurant` object and any
    ///           encountered error, or nil and nil if successful.
    private func parseRestaurant(from csvData: String) throws -> (Restaurant?, Error?) {
        let lines = csvData.components(separatedBy: "\n")
        
        // Validate and parse the first line
        guard let firstLine = lines.first, !firstLine.isEmpty else {
            return (nil, CSVError.invalidFormat)
        }
        
        let components = firstLine.components(separatedBy: ",")
        guard components.count >= 4 else {
            return (nil, CSVError.insufficientData)
        }
        
        let name = components[0]
        guard let restaurantId = UUID(uuidString: components[1]) else {
            return (nil, CSVError.invalidUUIDFormat)
        }
        let location = components[2]
        let menuCSV = components[3]
        
        // Parse the menu data
        let menuItems = try parseMenuItems(from: menuCSV)
        
        // Create and return the restaurant object
        let menu = Menu(items: menuItems)
        return (Restaurant(name: name, location: location, menu: menu), nil)
    }
    
    /// Internal helper for parsing menu items from a CSV string.
    ///
    /// - Parameter menuCSV: The CSV string containing menu item data.
    /// - Throws: A `CSVError` if the format is invalid.
    /// - Returns: An array of parsed `MenuItem` objects.
    private func parseMenuItems(from menuCSV: String) throws -> [MenuItem] {
        var items = [MenuItem]()
        for menuItem in menuCSV.components(separatedBy: ";") {
            let components = menuItem.components(separatedBy: ",")
            guard components.count == 2 else {
                throw CSVError.invalidFormat
            }
            
            let itemName = components[0]
            guard let itemPrice = Double(components[1]) else {
                throw CSVError.invalidPriceFormat
            }
            
            let item = MenuItem(name: itemName, price: itemPrice)
            items.append(item)
        }
        return items
    }
}

enum CSVError: Error {
    case invalidFormat
    case invalidPriceFormat
    case insufficientData
    case invalidUUIDFormat
}

//
//  CSVLoader.swift
//  Dine
//
//  Created by doss-zstch1212 on 13/02/24.
//

import Foundation

struct CSVLoader {
    // MARK: - Restaurant load methods
    /// Loads a restaurant object from a CSV file.
    ///
    /// - Parameter filePath: The path to the CSV file.
    /// - Returns: A `Restaurant` object containing the data from the CSV file,
    ///           or nil if the file is invalid, empty, or an error occurs.
    func loadRestaurants() throws -> Restaurant? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw FileIOError.documentDirectoryUnavailable
        }
        
        // Append filename to the document directory URL
        let fileURL = documentDirectory.appendingPathComponent("restaurants.csv")
        let csvData = try String(contentsOf: fileURL)
        
        // Parse the CSV data
        let (restaurant, error) = try parseRestaurant(from: csvData)
        if let error {
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
        let restaurantLines = csvData.components(separatedBy: "\n")
        
        
        // Extract the header line and remove it from the array
        let headerLine = restaurantLines[0]
        let restaurantDataLine = Array(restaurantLines.dropFirst())
        
        // Parse the header line to ensure it has the correct format
        let headerComponents = headerLine.components(separatedBy: ",")
        guard headerComponents.count == 4,
              headerComponents[0] == "Name",
              headerComponents[1] == "RestaurantID",
              headerComponents[2] == "Location",
              headerComponents[3] == "Menu" else {
            throw CSVError.invalidFormat
        }
        
        guard let restaurantData = restaurantDataLine.first else {
            throw CSVError.insufficientData
        }
        
        let restaurantComponents = restaurantData.components(separatedBy: ",")
        let name = restaurantComponents[0]
        guard let restaurantId = UUID(uuidString: restaurantComponents[1]) else {
            return (nil, CSVError.invalidUUIDFormat)
        }
        let location = restaurantComponents[2]
        let menuCSV = restaurantComponents[3]
        
        // Parse the menu data
        guard let menuItems = try parseMenuItems(from: menuCSV) else {
            let menu = Menu()
            return (Restaurant(name: name, location: location, menu: menu), nil)
        }
        
        // Create and return the restaurant object
        let menu = Menu(items: menuItems)
        return (Restaurant(name: name, location: location, menu: menu), nil)
    }
    
    /// Internal helper for parsing menu items from a CSV string.
    ///
    /// - Parameter menuCSV: The CSV string containing menu item data.
    /// - Throws: A `CSVError` if the format is invalid.
    /// - Returns: An array of parsed `MenuItem` objects.
    private func parseMenuItems(from menuCSV: String) throws -> [MenuItem]? {
        // Split menu CSV into individual lines
        let menuLines = menuCSV.components(separatedBy: "\n")
        
        // Check if there's at least one line for the header and one line for menu items
        guard menuLines.count >= 2 else {
            return []
        }
        
        // Extract the header line and remove it from the array
        let headerLine = menuLines[0]
        let menuDataLines = Array(menuLines.dropFirst())
        
        // Parse the header line to ensure it has the correct format
        let headerComponents = headerLine.components(separatedBy: ",")
        guard headerComponents.count == 2,
              headerComponents[0] == "Name",
              headerComponents[1] == "Price" else {
            throw CSVError.invalidFormat
        }
        
        // Create an array to store menu items
        var items = [MenuItem]()
        
        // Parse each line
        for line in menuDataLines {
            let components = line.components(separatedBy: ",")
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

/// This is how the CSV looks like. Thank me later ;)
/*
 Name,RestaurantID,Location,Menu
 Restaurant A,3C319306-C25F-4C85-9DF8-5E2D791FF80A,123 Main St,Name,Price
 Item A1,10.99
 Item A2,8.99
 Item A3,10.98
 Item A4,8.98
*/

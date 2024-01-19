//
//  RestaurantConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 19/01/24.
//

import Foundation

struct RestaurantConsoleView: ConsolePrinter, CommandLineInputHandler {
    func prompt() -> String? {
        print("Enter the Restaurant name: ")
        let restaurantName = readLine()
        return restaurantName
    }
}

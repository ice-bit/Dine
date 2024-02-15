//
//  main.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

// username: TechDev_123
// TechDev768
// password: StrongP@ss123

import Foundation

func getMenu() -> Menu {
    let menuItems: [MenuItem] = [
        MenuItem(name: "Burger", price: 9.99),
        MenuItem(name: "Pizza", price: 12.99),
        MenuItem(name: "Salad", price: 7.49),
        MenuItem(name: "Pasta", price: 10.99),
        MenuItem(name: "Steak", price: 15.99),
        MenuItem(name: "Sushi", price: 18.49),
        MenuItem(name: "Sandwich", price: 8.99),
        MenuItem(name: "Soup", price: 6.99),
        MenuItem(name: "Fish and Chips", price: 11.99),
        MenuItem(name: "Tacos", price: 9.49),
        MenuItem(name: "Chicken Curry", price: 13.99),
        MenuItem(name: "Burrito", price: 10.49),
        MenuItem(name: "Fried Rice", price: 8.49),
        MenuItem(name: "Caesar Salad", price: 7.99),
        MenuItem(name: "Hot Dog", price: 5.99),
        MenuItem(name: "Nachos", price: 9.99),
        MenuItem(name: "Quesadilla", price: 8.49),
        MenuItem(name: "Shrimp Scampi", price: 14.99),
        MenuItem(name: "Calzone", price: 11.49),
        MenuItem(name: "Chicken Wings", price: 9.99)
    ]
    
    return Menu(items: menuItems)
}

class Main {
    private let restaurant: Restaurant? = nil
    let userRepository: UserRepository = InMemoryUserRepository()
    
    // MARK: - Starting point...
    func start() {
        while !UserStatus.restaurantSetup.getStatus() {
            setupRestaurant()
        }
        
        while UserStatus.initialSetup.getStatus() {
            onboardUser()
        }
        
        startNormalFlow()
    }
    
    // MARK: - Normal flow
    private func startNormalFlow() {
        
        while !UserStatus.userLoggedIn.getStatus() {
            authenticateUser()
        }
        
        // Navigate to home screen
        displayHomeScreen()
    }
    
    // MARK: - Supporting methods
    private func authenticateUser() {
        let authConsoleView = AuthConsoleView(userRepository: userRepository)
        authConsoleView.startLogin()
    }
    
    private func onboardUser() {
        let authConsoleView = AuthConsoleView(userRepository: userRepository)
        authConsoleView.startSignUp()
    }
    
    private func setupRestaurant() {
        let setupConsoleView = SetupConsoleView()
        setupConsoleView.promptRestaurantSetup()
    }
    
    private func displayHomeScreen() {
        // Load Restaurant
        guard let restaurant = restaurant?.loadRestaurant() else {
            print("Restaurant not found")
            return
        }
        
        let homeConsoleView = HomeConsoleView(restaurant: restaurant, userRepository: userRepository)
        homeConsoleView.displayHomeOptions()
    }
    
    private func loadRes() -> Restaurant? {
        do {
            let restaurant = try CSVLoader().loadRestaurants()
            return restaurant
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func printRes() {
        if let restaurant = loadRes() {
            print(restaurant.menu.displayMenuItems())
        } 
    }
}

// MARK: - Caller
let main = Main()
//main.start()
main.printRes()

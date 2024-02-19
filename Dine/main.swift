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

@frozen enum UserStatus: String {
    case userLoggedIn = "isUserLoggedInTest2"
    case initialSetup = "isInitialStartUpTest2"
    case restaurantSetup = "isRestaurantSetUpTest2"
    
    func getStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: self.rawValue)
    }
    
    func updateStatus(_ status: Bool) {
        UserDefaults.standard.set(status, forKey: self.rawValue)
    }
}


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
    private var restaurantManager = RestaurantManager()
    let userRepository: UserRepository = InMemoryUserRepository()
    
    private var isUserLoggedIn: Bool = false
    private var isInitialSetup: Bool = true
    
    // MARK: - Starting point...
    /*func start() {
        while !UserStatus.restaurantSetup.getStatus() {
            setupRestaurant()
        }
        
        while UserStatus.initialSetup.getStatus() {
            onboardUser()
        }
        
        startNormalFlow()
    }*/
    
    // MARK: - Normal flow
    /*private func startNormalFlow() {
        
        while !UserStatus.userLoggedIn.getStatus() {
            authenticateUser()
        }
        
        // Navigate to home screen
        displayHomeScreen()
    }*/
    
    func start() {
        while isInitialSetup {
            setupRestaurant()
            
            onboardUser()
        }
        
        authenticateUser()
        
        while isUserLoggedIn {
            displayHomeScreen()
        }
        
        start()
    }
    
    // MARK: - Supporting methods
    private func setupRestaurant() {
        let setupConsoleView = SetupConsoleView(restaurantManager: restaurantManager)
        setupConsoleView.delegate = self
        setupConsoleView.promptRestaurantSetup()
    }
    
    private func onboardUser() {
        let authConsoleView = AuthConsoleView(userRepository: userRepository)
        authConsoleView.startSignUp()
    }
    
    private func authenticateUser() {
        let authConsoleView = AuthConsoleView(userRepository: userRepository)
        authConsoleView.delegate = self
        authConsoleView.startLogin()
    }
    
    private func displayHomeScreen() {
        guard let restaurant = restaurantManager.getRestaurant() else {
            print("No restaurants found")
            return
        }
        
        let homeConsoleView = HomeConsoleView(restaurant: restaurant, userRepository: userRepository)
        homeConsoleView.delegate = self
        homeConsoleView.displayHomeOptions()
    }
}

extension Main: LoginStateDelegate {
    func isUserLoggedIn(_ state: Bool) {
        isUserLoggedIn = state
    }
}

extension Main: InitialSetupTogglable {
    func toggleInitialSetup() {
        isInitialSetup.toggle()
    }
}

// MARK: - Caller
let main = Main()
main.start()

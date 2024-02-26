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
    func start() {
        let isUserLoggedIn = UserStatus.userLoggedIn.getStatus()
        //let restaurantExists = UserStatus.restaurantExists.getStatus()
        
        // Restaurant setup
        /*while isInitialSetup {
            setupRestaurant()
        }*/
        
        while !UserStatus.initialSetup.getStatus() {
            onboardUser()
        }
        
        while isUserLoggedIn {
            displayHomeScreen()
        }
        
        print("Endpoint occured!")
        
        //start() // Ignore warning!
    }
    
    // MARK: - Supporting methods
    private func setupRestaurant() {
        let setupConsoleView = SetupConsoleView()
        setupConsoleView.promptRestaurantSetup()
    }
    
    private func onboardUser() {
        let authController = AuthController()
        let authConsoleView = AuthConsoleView(authentication: authController)
        authConsoleView.startSignUp()
    }
    
    private func authenticateUser() {
        let authController = AuthController()
        let authConsoleView = AuthConsoleView(authentication: authController)
        authConsoleView.startLogin()
    }
    
    private func displayHomeScreen() {
        /*guard let restaurant = RestaurantManager.shared.getRestaurant() else {
            print("No restaurants found")
            return
        }*/
        
        let homeConsoleView = HomeConsoleView()
        //homeConsoleView.delegate = self
        homeConsoleView.displayHomeOptions()
    }
}

// MARK: - Test extension
extension Main {
    func printDataDictionary(_ dictionary: [[String: String]]) {
        for row in dictionary {
            for (key, value) in row {
                print("\(key): \(value)")
            }
            print("") // Add a newline between rows for better readability
        }
    }
    
    func testAdminController() {
        let admin = AdminController()
        let authController = AuthController()
        let adminConsoleView = AdminConsoleView(admin: admin, authentication: authController)
        adminConsoleView.displayAdminOption()
    }
    
    func testTables() {
        let csvReader = CSVReader()
        let csvParser = CSVParser()
        
        do {
            let data = try csvReader.readCSV(from: FileName.table.rawValue)
            print(data.description)
            print()
            let tables = csvParser.parseTables(from: data)
            //print("\(tables.description)")
        } catch {
            print("Error: \(error)")
        }
        displayHomeScreen()
    }
    
    func testAccount() {
        let csvReader = CSVReader()
        let csvParser = CSVParser()
        
        do {
            let data = try csvReader.readCSV(from: FileName.account.rawValue)
            print(data.description)
            let tables = csvParser.parseAccounts(from: data)
            print("\(tables.description)")
        } catch {
            print("Error: \(error)")
        }
    }
}

// MARK: - Caller
let main = Main()
//main.start()
//main.retrieveAccounts()

main.testTables()
//main.testAccount()
//main.testAdminController()

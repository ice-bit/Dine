//
//  LoginConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 24/01/24.
//

import Foundation

class LoginConsoleView {
    func displayLoginOptions() {
        print("Login as")
        print("1. Admin")
        print("2. Employee")
        print("3. Exit")
        handleLoginOption()
    }
    
    func handleLoginOption() {
        let choice = readLine() ?? ""
        switch choice {
        case "1":
            promptCredentailsForAdmin()
        case "2":
            promptCredentailsForEmployee()
        default:
            print("Invalid input.")
            displayLoginOptions()
        }
    }
    
    func promptCredentailsForEmployee() {
        print("Enter your credentials")
        print("Username:")
        let username = readLine() ?? ""
        print("Password:")
        let password = readLine() ?? ""
        
        let loginController = LoginController()
        if let user = loginController.authenticateUser(username: username, password: password) {
            print("Logging successfull")
            // Navigating to next console view (Employee specific)
            
        } else {
            print("Failed to login")
        }
    }
    
    func promptCredentailsForAdmin() {
        print("Enter your credentials")
        print("Username:")
        let username = readLine() ?? ""
        print("Password:")
        let password = readLine() ?? ""
        
        let authController = AuthController()
        if let account = authController.validateLogin(username: username, password: password) {
            print("Logging successfull")
            
            // Navigating to next console view
        } else {
            print("Failed to login")
        }
    }
    
}

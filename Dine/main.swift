//
//  main.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Main {
    func startApp() {
        let isInitailSetup = UserStatus.initialSetup.getStatus()
        let isUserLoggedIn = UserStatus.userLoggedIn.getStatus()
        
        if isInitailSetup {
            setupRestaurant()
            onboardAdmin()
        } else {
            if !isUserLoggedIn {
                userAuthentication()
            }
            
            while true {
                routeUser()
            }
        }
    }
    
    private func setupRestaurant() {
        let restaurantSetupController = RestaurantSetupController()
        let restaurantSetupConsoleView = RestaurantSetupConsoleView(restaurantSetupProtocol: restaurantSetupController)
        restaurantSetupConsoleView.promptRestaurantSetup()
    }
    
    private func onboardAdmin() {
        let adminController = AdminController()
        let authenticateController = AuthController()
        let adminConsoleView = AdminConsoleView(admin: adminController, authentication: authenticateController)
        adminConsoleView.displayAdminOption()
    }
    
    private func userAuthentication() {
        let authenticateController = AuthController()
        let authenticationConsoleView = AuthConsoleView(authentication: authenticateController)
        authenticationConsoleView.userLogin()
    }
    
    private func routeUser() {
        let userStore = UserStore()
        if let currentAccount = userStore.getCurrentUser() {
            let userRouting = UserRouter(account: currentAccount)
            userRouting.routeUser()
        } else {
            print("No current user found!")
        }
    }
    
    func login(as userRole: UserRole) {
        switch userRole {
        case .admin:
            let account = Account(username: "AdminIsAlwaysRight_123", password: "StrongP@ss123", accountStatus: .active, userRole: .admin)
            let userRouting = UserRouter(account: account)
            userRouting.routeUser()
        case .manager:
            let account = Account(username: "ManagerIsAlwaysBusy_234", password: "StrongP@ss123", accountStatus: .active, userRole: .manager)
            let userRouting = UserRouter(account: account)
            userRouting.routeUser()
        case .waitStaff:
            let account = Account(username: "Wait_staffBaby123", password: "StrongP@ss123", accountStatus: .active, userRole: .waitStaff)
            let userRouting = UserRouter(account: account)
            userRouting.routeUser()
        case .kitchenStaff:
            let account = Account(username: "GoldenKitchen_432", password: "StrongP@ss123", accountStatus: .active, userRole: .kitchenStaff)
            let userRouting = UserRouter(account: account)
            userRouting.routeUser()
        case .employee:
            print()
        }
    }
}

let main = Main()
//main.startApp()
main.login(as: .manager)

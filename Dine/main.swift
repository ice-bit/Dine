//
//  main.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation
import NotificationCenter

class Main {
    private var applicationMode: ApplicationMode = .signedOut {
        didSet {
            print("Mode changed to \(applicationMode)")
        }
    }
    var databaseAccess: DatabaseAccess? {
        try? SQLiteDataAccess.openDatabase()
    }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationModeDidChange), name: .applicationModeDidChanged, object: nil)
    }
    
    func start() {
        if !UserDefaults.hasOnboarded {
            onBoardUser()
        }
        switch applicationMode {
        case .signedIn:
            routeUser()
        case .signedOut:
            userAuthentication()
        }
    }
    
    func onBoardUser() {
        guard let databaseAccess else { return }
        if loadDB() {
            if setupRestaurant() {
                print("Restaurant setup complete")
                if createAdmin(databaseAccess: databaseAccess) {
                    print("Default Admin account created")
                    if changeAdminPassword() {
                        print("Admin password changed successfully")
                        UserDefaults.hasOnboarded = true
                    }
                }
            }
        }
    }
    
    private func loadDB() -> Bool {
        guard let fileURL = createFileURL() else {
            print("Failed to get file URL.")
            return false
        }
        
        print("Database file path: \(fileURL.path)")
        
        do {
            try createDatabaseTables()
            return true
        } catch {
            print("An error occurred: \(error)")
        }
        return false
    }
    
    private func createFileURL() -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Document directory unavailable.")
            return nil
        }
        
        return documentDirectory.appendingPathComponent("dine.sqlite")
    }
    
    private func createDatabaseTables() throws {
        guard let databaseAccess = databaseAccess else {
            print("Failed to open database connection!")
            return
        }
        try databaseAccess.createTable(for: Account.self)
        try databaseAccess.createTable(for: Restaurant.self)
        try databaseAccess.createTable(for: Order.self)
        try databaseAccess.createTable(for: MenuItem.self)
        try databaseAccess.createTable(for: Bill.self)
        try databaseAccess.createTable(for: RestaurantTable.self)
        try databaseAccess.createTable(for: OrderItem.self)
        print("Info: Tables created successfully.")
    }
    
    private func createAdmin(databaseAccess: DatabaseAccess) -> Bool {
        let adminAccount = Account(username: "admin", password: "12345678", accountStatus: .active, userRole: .admin)
        UserStore.setUser(userID: adminAccount.userId)
        do {
            try databaseAccess.insert(adminAccount)
            return true
        } catch {
            print("Failed to insert")
            return false
        }
    }
    
    private func changeAdminPassword() -> Bool {
        guard let databaseAccess = databaseAccess else {
            print("Failed to open database connection!")
            return false
        }
        let accountService = AccountServiceImpl(databaseAccess: databaseAccess)
        let adminController: AdminPrivilages = AdminController(accountService: accountService)
        let authController = AuthController(databaseAccess: databaseAccess)
        let adminConsoleView = AdminConsoleView(admin: adminController, authentication: authController)
        if adminConsoleView.changeAdminPassword() {
            return true
        } else {
            return false
        }
    }
    
    private func setupRestaurant() -> Bool {
        guard let databaseAccess = databaseAccess else {
            print("Failed to open database connection!")
            return false
        }
        let restaurantSetupController = RestaurantSetupController(databaseAccess: databaseAccess)
        let restaurantSetupConsoleView = RestaurantSetupConsoleView(restaurantSetupProtocol: restaurantSetupController)
        if restaurantSetupConsoleView.promptRestaurantSetup() {
            return true
        }
        return false
    }
    
    private func onboardAdmin() {
        guard let databaseAccess = databaseAccess else {
            print("Failed to open database connection!")
            return
        }
        let accountService = AccountServiceImpl(databaseAccess: databaseAccess)
        let adminController: AdminPrivilages = AdminController(accountService: accountService)
        let authenticateController: Authentication = AuthController(databaseAccess: databaseAccess)
        let adminConsoleView = AdminConsoleView(admin: adminController, authentication: authenticateController)
        adminConsoleView.displayAdminOption()
    }
    
    private func userAuthentication() {
        guard let databaseAccess = databaseAccess else {
            print("Failed to open database connection!")
            return
        }
        let authenticateController = AuthController(databaseAccess: databaseAccess)
        let authenticationConsoleView = AuthConsoleView(authentication: authenticateController)
        authenticationConsoleView.userLogin()
    }
    
    private func routeUser() {
        guard let currentAccount = UserStore.getCurrentUser() else {
            print("No user found")
            return
        }
        
        let userRouting = UserRouter(account: currentAccount)
        userRouting.routeUser()
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

extension Main {
    @objc func applicationModeDidChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let newMode = userInfo["newMode"] as? ApplicationMode else { return }
        applicationMode = newMode
    }
}

let main = Main()
//main.login(as: .waitStaff)
while true {
    main.start()
}











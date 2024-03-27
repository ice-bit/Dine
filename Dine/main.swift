//
//  main.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation
import NotificationCenter

class Main {
    private var applicationMode: ApplicationMode = .idle {
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
        switch applicationMode {
        case .signedIn:
            routeUser()
        case .signedOut:
            userAuthentication()
        case .initialSetup:
            if verifyAndSetup() {
                applicationMode = .signedOut
            }
        case .idle:
            applicationMode = .initialSetup
        }
    }
    
    private func verifyAndSetup() -> Bool {
        guard let databaseAccess else {
            print("Failed to open database connection!")
            return false
        }
        let dbService = DatabaseService(databaseAccess: databaseAccess)
        if !dbService.verifyTablesExistence() {
            loadDB()
        }
        if !dbService.verifyRestaurantExistence() {
            setupRestaurant()
        } else {
            print("Restaurant exists")
        }
        if !dbService.verifyAdminExistence() {
            do {
                try createAdmin(databaseAccess: databaseAccess)
            } catch {
                print(error)
            }
        } else {
            print("Admin exists")
        }
        return true
    }
    
    private func loadDB() {
        guard let fileURL = createFileURL() else {
            print("Failed to get file URL.")
            return
        }
        
        print("Database file path: \(fileURL.path)")
        
        do {
            try createDatabaseTables()
            return
        } catch {
            print("An error occurred: \(error)")
        }
        return
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
        
        do {
            try databaseAccess.createTable(for: Account.self)
            try databaseAccess.createTable(for: Restaurant.self)
            try databaseAccess.createTable(for: Order.self)
            try databaseAccess.createTable(for: MenuItem.self)
            try databaseAccess.createTable(for: Bill.self)
            try databaseAccess.createTable(for: RestaurantTable.self)
            try databaseAccess.createTable(for: OrderItem.self)
            print("Info: Tables created successfully.")
        } catch let error as SQLiteError {
            throw error
        }
    }
    
    private func createAdmin(databaseAccess: DatabaseAccess) throws {
        let adminAccount = Account(username: "admin", password: "12345678", accountStatus: .active, userRole: .admin)
        UserStore.setUser(userID: adminAccount.userId)
        try databaseAccess.insert(adminAccount)
    }
    
    private func changeAdminPassword() {
        guard let databaseAccess = databaseAccess else {
            print("Failed to open database connection!")
            return
        }
        let accountService = AccountServiceImpl(databaseAccess: databaseAccess)
        let adminController: AdminPrivilages = AdminController(accountService: accountService)
        let authController = AuthController(databaseAccess: databaseAccess)
        let adminConsoleView = AdminConsoleView(admin: adminController, authentication: authController)
        adminConsoleView.changeAdminPassword()
    }
    
    private func setupRestaurant() {
        guard let databaseAccess = databaseAccess else {
            print("Failed to open database connection!")
            return
        }
        let restaurantSetupController = RestaurantSetupController(databaseAccess: databaseAccess)
        let restaurantSetupConsoleView = RestaurantSetupConsoleView(restaurantSetupProtocol: restaurantSetupController)
        return restaurantSetupConsoleView.promptRestaurantSetup()
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











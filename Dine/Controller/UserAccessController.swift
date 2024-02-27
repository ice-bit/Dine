//
//  UserAccessController.swift
//  Dine
//
//  Created by doss-zstch1212 on 27/02/24.
//

import Foundation

struct UserAccessController {
    private let account: Account

    init(account: Account) {
        self.account = account
    }
    
    func redirectUser() {
        let userRole = account.userRole
        switch userRole {
        case .admin:
            redirectAdmin()
        case .manager:
            redirectManager()
        case .waitStaff:
            redirectWaitStaff()
        case .kitchenStaff:
            redirectKitchenStaff()
        case .employee:
            print()
        }
    }
    
    private func redirectAdmin() {
        let adminController: AdminPrivilages = AdminController()
        let authController: Authentication = AuthController()
        let adminConsoleView = AdminConsoleView(admin: adminController, authentication: authController)
        adminConsoleView.displayAdminOption()
    }
    
    private func redirectManager() {
        let managerConsoleView = ManagerConsoleView(account: account)
        managerConsoleView.displayManagerOptions()
    }
    
    private func redirectWaitStaff() {
        let waitStaffConsoleView = WaitStaffConsoleView(account: account)
        waitStaffConsoleView.displayOptions()
    }
    
    private func redirectKitchenStaff() {
        let kitchenStaffConsoleView = KitchenStaffConsoleView(account: account)
        kitchenStaffConsoleView.displayOptions()
    }
}

//
//  AuthConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 23/01/24.
//

import Foundation

struct AuthConsoleView {
    func promptAdminCredentials() {
        print("Enter new username:")
        let username = readLine() ?? ""
        print("Enter new password:")
        let password = readLine() ?? ""
        
        let authController = AuthController()
        let adminAccount = authController.createAccount(username: username, password: password, userRole: .admin)
    }
    
    func mapConsoleView() {
        
    }
}

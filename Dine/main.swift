//
//  main.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

// username: TechDev_123
// password: StrongP@ss123

import Foundation

class Main {
    private let userManager: UserManagabale
    private var isUserLoggedIn: Bool = false
    
    init(userManager: UserManagabale) {
        self.userManager = userManager
    }
    
    func start() {
        startSignUp()
    }
    
    func startSignUp() {
        let signUpController = SignUpController(userManager: userManager)
        do {
            try signUpController.initiateAccountRegistration()
            isUserLoggedIn = true
        } catch let error as SignUpError {
            signUpController.handleSignUpError(error)
        } catch {
            print("Unknown error: \(error)")
        }
    }
}

let userManager = UserManager()
let main = Main(userManager: userManager)
main.start()




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
    private var isUserLoggedIn: Bool = false {
        didSet {
            print("Login state changed -> \(isUserLoggedIn)")
        }
    }
    
    init(userManager: UserManagabale) {
        self.userManager = userManager
    }
    
    func start() {
        //signUp()
        login()
    }
    
    func signUp() {
        let signUpController = SignUpController(userManager: userManager)
        do {
            try signUpController.initiateAccountRegistration()
        } catch let error as SignUpError {
            signUpController.handleSignUpError(error)
        } catch {
            print("Unknown error: \(error)")
        }
    }
    
    func login() {
        let loginController = LoginController(userManager: userManager)
        if loginController.loginUser() {
            isUserLoggedIn = true
        } else {
            isUserLoggedIn = false
        }
    }
}

let userManager = UserManager()
let main = Main(userManager: userManager)
main.start()




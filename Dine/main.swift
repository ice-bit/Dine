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
        startAuth()
    }

    func startAuth() {
        let consoleView: ConsoleViewable = AuthConsoleView()
        let authCon = AuthController(authConsoleView: consoleView)
        authCon.run()
    }
}

let userManager = UserManager()
let main = Main(userManager: userManager)
main.start()




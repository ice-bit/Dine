//
//  main.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

// username: TechDev_123
// password: StrongP@ss123
import Foundation

print("Hey!")
let userManager: UserManagabale = UserManager()
let authConsoleView = AuthConsoleView(userManager: userManager)
authConsoleView.displaySignUpPrompt()
//print("\(userManager.getNumberOfUsers())")
/*
let centralizedUser = UserManager(users: [])
let createUser = SignUpController(userManager: centralizedUser)
let loginUser = LoginController(userManager: centralizedUser)
createUser.createAccount(username: "Itachi123", password: "Hellloooooo1@", role: .manager)
let isUserPresent: Bool = loginUser.authenticateUserCredentials(username: "Itachi123", password: "Hellloooooo1@")
print(isUserPresent)
*/

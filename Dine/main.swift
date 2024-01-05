//
//  main.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

print("Hey!")

let centralizedUser = UserManager(users: [])
let createUser = SignUpController(userManager: centralizedUser)
let loginUser = LoginController(usernameManager: centralizedUser)
createUser.createAccount(username: "Itachi123", password: "Hellloooooo1@", role: .manager)
let isUserPresent: Bool = loginUser.LoginUser(username: "Itachi123", password: "Hellloooooo1@")
print(isUserPresent)

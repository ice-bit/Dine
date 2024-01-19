//
//  AuthConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 10/01/24.
//

import Foundation

class AuthConsoleView: ConsolePrinter, CommandLineInputHandler  {
    func prompt() -> (String, String) {
        print("Enter username: ", terminator: "")
        let username = readLine() ?? ""
        print("Enter password: ", terminator: "")
        let password = readLine() ?? ""
        return (username, password)
    }
}

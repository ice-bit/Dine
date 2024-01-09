//
//  SignUpConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 09/01/24.
//

import Foundation

class SignUpConsoleView {
    func displaySignUpPrompt(completion: (String, String) -> Void) {
        print("Enter a new username: ", terminator: "")
        guard let username = readLine() else {
            print("Enter a valid username!")
            return
        }
        
        print("Enter a new password: ", terminator: "")
        guard let password = readLine() else {
            print("Enter a valid password!")
            return
        }
        
        completion(username, password)
    }
    
    func promptUsername() -> String? {
        print("Enter new username: ")
        return readLine()
    }
    
    func promptPassword() -> String? {
        print("Enter new username: ")
        return readLine()
    }
}

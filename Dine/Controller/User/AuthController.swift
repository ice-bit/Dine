//
//  AuthController.swift
//  Dine
//
//  Created by doss-zstch1212 on 10/01/24.
//

import Foundation

protocol AuthStateObserver: AnyObject {
    func didLogin(userId: String)
    func didLogout()
}

class AuthController {
    let authConsoleView: ConsoleViewable
    private var isUserLoggedIn: Bool = false
    
    weak var authState: AuthStateObserver?
    
    init(authConsoleView: ConsoleViewable) {
        self.authConsoleView = authConsoleView
    }
    
    private func signUp() {
        // Get credentials from the user
        let (username, password) = authConsoleView.prompt()

        // Validate username
        guard AuthenticationValidator.isValidUsername(username) else {
            print("Invalid username!")
            return
        }

        // Validate password strength
        guard AuthenticationValidator.isStrongPassword(password) else {
            print("Password not strong enough!")
            return
        }

        // Check if the username is already taken
        let fileService = FileService()
        let fileName = "\(username).json"
        guard !fileService.doesFileExistInDocumentDirectory(fileName: fileName) else {
            print("Username not available.")
            return
        }

        // Create a new account
        let account = Account(id: username, password: password, accountStatus: .active, userRole: .manager)

        // Save the account
        do {
            try saveAccount(account)
            print("Account created successfully!")
            isUserLoggedIn = true
        } catch {
            print("Error saving account: \(error)")
        }
    }

    
    private func login() {
        let fileIO = FileIOService()
        let (username, password) = authConsoleView.prompt()

        let fileService = FileService()
        
        // Check if the user file exists
        let userFileExists = fileService.doesFileExistInDocumentDirectory(fileName: "\(username).json")
        guard userFileExists else {
            print("User doesn't exist.")
            return
        }

        // Attempt to read the account information
        do {
            if let account: Account = try fileIO.read(from: "\(username).json") {
                // Check if the entered password matches the stored password
                if account.getPassword() == password {
                    print("Successfully logged in!")
                    isUserLoggedIn = true
                } else {
                    print("Incorrect password.")
                }
            }
        } catch {
            print("Error occurred while logging in: \(error)")
        }
    }
    
    private func saveAccount(_ account: Account) throws {
        let fileIO = FileIOService()
        let modalJSONSerializer = ModelJSONSerializer()
        let data = try modalJSONSerializer.modelToJSON(model: account)
        try fileIO.write(data: data, into: "\(account.getId()).json")
    }
    
    /*private func forgotPassword() {
        let editCon = EditAccountController(userManager: userManager)
        let (username, password) = authConsoleView.prompt()
        if editCon.changePassword(username: username, password: password) {
            print("Password changed!")
        } else {
            print("Sorry unable to change the password!")
            run()
        }
    }*/
    
    func run() {
        print("1. Sign Up\n2. Login\n3. Forgot Password\n4. Exit")
        let choice = authConsoleView.getInput()
        
        switch choice {
        case "1":
            signUp()
        case "2":
            login()
        case "3":
            //forgotPassword()
            print("yet to Implement")
        case "4":
            exit(0)
        default:
            authConsoleView.show(message: "Invalid choice. Please try again.")
        }
    }
    
    deinit {
        print("AuthController is deinitialized!")
    }
}

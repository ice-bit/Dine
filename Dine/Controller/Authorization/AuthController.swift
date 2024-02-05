////
////  AuthController.swift
////  Dine
////
////  Created by doss-zstch1212 on 10/01/24.
////
//
//import Foundation
//
//protocol AuthStateObserver: AnyObject {
//    func didLogin(userId: String)
//    func didLogout()
//}
//
//struct AuthController {
//    private var isUserLoggedIn: Bool = false
//    
//    weak var authState: AuthStateObserver?
//    
//    private mutating func signUp() {
//        let authConsoleView = AuthConsoleView()
//        // Get credentials from the user
//        let (username, password) = authConsoleView.prompt()
//
//        // Validate username
//        guard AuthenticationValidator.isValidUsername(username) else {
//            print("Invalid username!")
//            return
//        }
//
//        // Validate password strength
//        guard AuthenticationValidator.isStrongPassword(password) else {
//            print("Password not strong enough!")
//            return
//        }
//
//        // Check if the username is already taken
//        let fileService = FileService()
//        let fileName = "\(username).json"
//        guard !fileService.doesFileExistInDocumentDirectory(fileName: fileName) else {
//            print("Username not available.")
//            return
//        }
//
//        // Create a new account
//        let account = Account(username: username, password: password, accountStatus: .active, userRole: .manager, branch: <#Branch#>)
//
//        // Save the account
//        do {
//            try saveAccount(account)
//            print("Account created successfully!")
//            isUserLoggedIn = true
//        } catch {
//            print("Error saving account: \(error)")
//        }
//    }
//
//    
//    private mutating func login() {
//        let fileIO = FileIOService()
//        let authConsoleView = AuthConsoleView()
//        let (username, password) = authConsoleView.prompt()
//
//        let fileService = FileService()
//        
//        // Check if the user file exists
//        let userFileExists = fileService.doesFileExistInDocumentDirectory(fileName: "\(username).json")
//        guard userFileExists else {
//            print("User doesn't exist.")
//            return
//        }
//        
//        let fileName = "\(username).json"
//        // Attempt to read the account information
//        fileIO.read(from: fileName) { (result: Result<Account?, FileIOError>) in
//            switch result {
//            case .success(let modal):
//                if let modal = modal {
//                    if modal.getPassword() == password {
//                        print("Successfully logged in")
//                        UserDefaults.setValue(true, forKey: "isUserLoggedIn")
//                    }
//                } else {
//                    print("No person data found")
//                }
//            case .failure(let error):
//                print("Error reading file: \(error)")
//            }
//        }
//    }
//    
//    private func saveAccount(_ account: Account) throws {
//        let fileIO = FileIOService()
//        let modalJSONSerializer = ModelJSONSerializer()
//        let data = try modalJSONSerializer.modelToJSON(model: account)
//        let fileName = "\(account.getUsername()).json"
//        fileIO.write(data: data, into: fileName) { result in
//            switch result {
//            case .success(_):
//                print("Successfully wrote to file.")
//            case .failure(let error):
//                print("Failed to wirte to file: \(error)")
//            }
//        }
//    }
//    
//    /*private func forgotPassword() {
//        let editCon = EditAccountController(userManager: userManager)
//        let (username, password) = authConsoleView.prompt()
//        if editCon.changePassword(username: username, password: password) {
//            print("Password changed!")
//        } else {
//            print("Sorry unable to change the password!")
//            run()
//        }
//    }*/
//    
//    mutating func run() {
//        print("1. Sign Up\n2. Login\n3. Forgot Password\n4. Exit")
//        let authConsoleView = AuthConsoleView()
//        let choice = authConsoleView.getInput()
//        
//        switch choice {
//        case "1":
//            signUp()
//        case "2":
//            login()
//        case "3":
//            //forgotPassword()
//            print("yet to Implement")
//        case "4":
//            exit(0)
//        default:
//            authConsoleView.show(message: "Invalid choice. Please try again.")
//        }
//    }
//}

import Foundation

struct AuthController {
    
    /// Creates new account and save it to file.
    func createAccount(username: String, password: String, userRole: UserRole) -> Bool {
        // Check if username already exists
        guard !FileIOService.fileExists(withName: "\(username).json") else {
            print("Admin with \(username) already exists!")
            return false
        }
        
        // Validate username
        guard AuthenticationValidator.isValidUsername(username) else {
            print("Invalid username!")
            return false
        }
        
        // Validate password strength
        guard AuthenticationValidator.isStrongPassword(password) else {
            print("Password not strong enough!")
            return false
        }
        
        let account = Account(username: username, password: password, accountStatus: .active, userRole: userRole)
        
        // Save account to file
        if FileIOService.saveDataToFile(data: account, fileName: "\(username).json") {
            print("Successfully saved account to file.")
            return true
        } else {
            print("Fialed to save account to file.")
        }
        UserDefaults.standard.setValue(false, forKey: "isInitialSetupComplete")
        return true
    }
    
    /// Validates the credentials for login.
    func validateLogin(username: String, password: String) -> Account? {
        guard FileIOService.fileExists(withName: "\(username).json") else {
            print("User doesn't exists.")
            return nil
        }
        
        do {
            if let account: Account = try FileIOService.readDataFromFile(fileName: "\(username).json") {
                if account.getPassword() == password {
                    print("Logged in successfuly.")
                    return account
                } else {
                    print("Logging failed for user: \(username).")
                    return nil
                }
            }
        } catch {
            print("Error encountered: \(error)")
        }
        
        return nil
    }
}

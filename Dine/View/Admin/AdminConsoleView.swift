//
//  AdminConsoleView.swift
//  Dine
//
//  Created by goutham on 23/01/24.
//

import Foundation
import NotificationCenter

struct AdminConsoleView {
    private let admin: AdminPrivilages
    private let authentication: Authentication
    init(admin: AdminPrivilages, authentication: Authentication) {
        self.admin = admin
        self.authentication = authentication
    }
    
    func displayAdminOption() {
        print("1. Create Account")
        print("2. Remove Account")
        print("3. View Accounts")
        print("4. Change Password")
        print("0. Sign Out")
        handleAdminOptions()
    }
    
    private func handleAdminOptions() {
        let choice = readLine() ?? ""
        switch choice {
        case "1":
            // redirect to creating account
            promptCreateAccount()
        case "2":
            // redirect to remove account
            displayAndChooseAccountToRemove()
        case "3":
            // redirect to viewing accounts
            displayAccounts()
        case "4":
            //redirect to change password
            changePassword()
        case "0": // Sign out
            UserStore.removeCurrentUser()
            NotificationCenter.default.post(name: .applicationModeDidChanged, object: nil, userInfo: ["newMode": ApplicationMode.signedOut])
            return
        default:
            print("Invalid input! Try again.")
            handleAdminOptions()
        }
    }
    
    private func promptCreateAccount() {
        print("New Username:")
        let username = readLine() ?? ""
        print("New Password:")
        let password = readLine() ?? ""
        guard let userRole = promptUserRole() else { return }
        
        do {
            try authentication.createAccount(username: username, password: password, userRole: userRole)
        } catch {
            print("Auth error: \(error)")
        }
        
    }
    
    private func promptUserRole() -> UserRole? {
        let userRoles = UserRole.allCases
        
        while true {
            print("Enter the number of the status you want to set (or 0 to cancel):")
            for (index, userRole) in userRoles.enumerated() {
                print("\(index + 1). \(userRole)")
            }
            
            if let choiceString = readLine(), let statusNumber = Int(choiceString) {
                if statusNumber >= 1 && statusNumber <= userRoles.count {
                    let chosenStatus = userRoles[statusNumber - 1]
                    print("Status set to: \(chosenStatus)")
                    return chosenStatus
                } else {
                    print("Invalid choice. Please enter a number between 1 and \(userRoles.count) or 0 to cancel.")
                }
            } else {
                print("Invalid input. Please enter a number.")
            }
        }
    }
    
    private func displayAndChooseAccountToRemove() {
        guard let accounts = try? admin.getAccounts() else {
            print("No users found!")
            return
        }
        
        for (index, account) in accounts.enumerated() {
            print("\(index + 1) - \(account.username)")
        }
        
        print("Enter the number of the account you want to choose (or 0 to cancel):")
        if let choice = readLine(), let accountNumber = Int(choice), accountNumber >= 1, accountNumber <= accounts.count {
            let chosenAccount = accounts[accountNumber - 1]
            print("Selected \(chosenAccount.username)")
            do {
                try admin.removeAccount(user: chosenAccount)
            } catch {
                print("Account removal failed with error: \(error)")
            }
        } else {
            print("Invalid choice or canceled.")
            displayAndChooseAccountToRemove()
        }
    }
    
    private func displayAndSelectAccount() -> Account? {
        guard let accounts = try? admin.getAccounts() else {
            print("No users found!")
            return nil
        }
        
        for (index, account) in accounts.enumerated() {
            print("\(index + 1) - \(account.username)")
        }
        
        print("Enter the number of the account you want to choose (or 0 to cancel):")
        if let choice = readLine(), let accountNumber = Int(choice), accountNumber >= 1, accountNumber <= accounts.count {
            let chosenAccount = accounts[accountNumber - 1]
            print("Selected \(chosenAccount.username)")
            return chosenAccount
        } else {
            print("Invalid choice or canceled.")
            return nil
        }
    }
    
    private func promptPassword() -> String {
        print("Enter new password:")
        let newPassword = readLine() ?? ""
        return newPassword
    }
    
    private func changePassword() {
        guard let selectedAccount = displayAndSelectAccount() else {
            print("No accounts selected")
            return
        }
        
        let newPassword = promptPassword()
        do {
            try admin.changePassword(for: selectedAccount.username, to: newPassword)
        } catch is AuthenticationError {
            print("Authentication error")
        } catch {
            // Handle other potential errors (e.g., network issues, database errors)
            print("Unexpected error: \(error.localizedDescription)")
        }
    }
    
    func changeAdminPassword() -> Bool {
        print("Set new password:")
        let password = readLine() ?? ""
        do {
            if try admin.changePassword(for: "admin", to: password) {
                return true
            }
        } catch {
            print("Password renewal failed with error: \(error)")
        }
        return false
    }
    
    private func displayAccounts() {
        guard let accounts = try? admin.getAccounts() else {
            print("No users found!")
            return
        }
        
        for (index, account) in accounts.enumerated() {
            print("\(index + 1) - \(account.username)")
        }
    }
}

//
//  UserStore.swift
//  Dine
//
//  Created by doss-zstch1212 on 28/02/24.
//

import Foundation

struct UserStore {
    static func setUser(userID: UUID) {
        UserDefaults.standard.set(userID.uuidString, forKey: UserDefaults.Keys.currentUserID)
    }
    
    static func getCurrentUser() -> Account? {
        guard let currentUserIDString = UserDefaults.standard.value(forKey: UserDefaults.Keys.currentUserID) as? String else {
            print("Current user unavailable!")
            return nil
        }
        guard let databaseAccess = try? SQLiteDataAccess.openDatabase() else {
            print("Failed to open database connect")
            return nil
        }
        
        let fetchUserQuery = "SELECT * FROM \(DatabaseTables.accountTable.rawValue) WHERE UserID = '\(currentUserIDString)';"
        do {
            guard let result = try databaseAccess.retrieve(query: fetchUserQuery, parseRow: Account.parseRow).first as? Account else {
                print("No users found!")
                return nil
            }
            // Return fetched user
            return result
        } catch {
            print("Failed to fetch account with error: \(error)")
        }
        return nil
    }
    
    static func removeCurrentUser() {
        UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.currentUserID)
    }
}


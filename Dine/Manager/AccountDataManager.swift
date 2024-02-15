//
//  AccountDataManager.swift
//  Dine
//
//  Created by doss-zstch1212 on 13/02/24.
//

import Foundation

class AccountDataManager {
    static let shared = AccountDataManager()
    
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    private let accountsKey = "UserAccounts"
    
    func saveAccount(_ accounts: [Account]) {
        do {
            let encoder = JSONEncoder()
            let encodedAccounts = try encoder.encode(accounts)
            userDefaults.set(encodedAccounts, forKey: accountsKey)
        } catch {
            print("Error encoding accounts: \(error)")
        }
    }
    
    /*func loadAccounts() -> [Account]? {
        guard let encodedAccounts = userDefaults.data(forKey: accountsKey) else { return nil }
        do {
            let decoder = JSONDecoder()
            let accounts = try decoder.decode([Account].self, from: encodedAccounts)
        } catch {
            print("Error decoding accounts: \(error)")
            return nil
        }
    }*/

    
}

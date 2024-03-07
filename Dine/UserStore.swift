//
//  UserStore.swift
//  Dine
//
//  Created by doss-zstch1212 on 28/02/24.
//

import Foundation

struct UserStore {
    func setUser(account: Account) {
        let accountData = try?  JSONEncoder().encode(account)
        UserDefaults.standard.set(accountData, forKey: UserDefaultsKeys.currentUserKey.rawValue)
    }
    
    func getCurrentUser() -> Account? {
        if let accountData = UserDefaults.standard.data(forKey: UserDefaultsKeys.currentUserKey.rawValue),
           let account = try? JSONDecoder().decode(Account.self, from: accountData) {
            return account
        }
        
        return nil
    }
    
    func removeCurrentUser() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.currentUserKey.rawValue)
    }
}



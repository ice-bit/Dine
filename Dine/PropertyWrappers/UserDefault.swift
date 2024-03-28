//
//  UserDefault.swift
//  Dine
//
//  Created by doss-zstch1212 on 28/03/24.
//

import Foundation

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard
    
    var wrappedValue: Value {
        get {
            container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}

extension UserDefaults {
    public enum Keys {
        static let hasOnboarded = "has_onboarded"
        static let currentUserID = "current_user_id"
    }
    
    @UserDefault(key: "has_onboarded", defaultValue: false)
    static var hasOnboarded: Bool
}

//
//  Account.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

enum AccountStatus: Int {
    case active = 1
    case closed = 2
    case cancelled = 3
}

class Account {
    private var id: String
    private var password: String
    private var accountStatus: AccountStatus
    
    init(id: String, password: String, accountStatus: AccountStatus) {
        self.id = id
        self.password = password
        self.accountStatus = accountStatus
    }
}

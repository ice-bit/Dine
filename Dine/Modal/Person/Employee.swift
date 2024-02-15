//
//  Employee.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Employee: Person {
    private var employeeId: UUID
    private var dateJoined = Date()
    private let account: Account
    private let restaurantId: UUID
    
    init(name: String, email: String, phoneNumber: String, account: Account, restaurantId: UUID) {
        self.employeeId = UUID()
        self.account = account
        self.restaurantId = restaurantId
        super.init(name: name, email: email, phoneNumber: phoneNumber)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    func fetchPassword() -> String {
        return account.password
    }
    
    func fetchUsername() -> String {
        return account.username
    }
}

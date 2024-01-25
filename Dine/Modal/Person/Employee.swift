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
    private let branch: Branch
    
    init(name: String, email: String, phoneNumber: String, account: Account) {
        self.employeeId = UUID()
        self.account = account
        super.init(name: name, email: email, phoneNumber: phoneNumber)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    func fetchPassword() -> String {
        return account.getPassword()
    }
    
    func fetchUsername() -> String {
        return account.getUsername()
    }
}

//
//  Employee.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Employee: Person {
    private var employeeId: Int
    private var dateJoined: Date
    
    init(name: String, email: String, phoneNumber: String, employeeId: Int, dateJoined: Date) {
        self.employeeId = employeeId
        self.dateJoined = dateJoined
        super.init(name: name, email: email, phoneNumber: phoneNumber)
    }
}

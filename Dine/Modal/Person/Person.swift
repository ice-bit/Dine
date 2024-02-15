//
//  Person.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Person: Codable {
    private var name: String
    private var email: String
    private var phoneNumber: String // format later
    
    init(name: String, email: String, phoneNumber: String) {
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
    }
}

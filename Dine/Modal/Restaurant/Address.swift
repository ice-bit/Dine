//
//  Address.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Address {
    private var streetAddress: String
    private var city: String
    private var state: String
    private var zipCode: String
    private var country: String
    
    init(street: String, city: String, state: String, zipCode: String, country: String) {
        self.streetAddress = street
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.country = country
    }
}

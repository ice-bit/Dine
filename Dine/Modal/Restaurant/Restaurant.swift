//
//  Restaurant.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Restaurant {
    private var name: String
    private var branches: [Branch]
    
    init(name: String, branches: [Branch]) {
        self.name = name
        self.branches = branches
    }
}

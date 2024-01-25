//
//  Kitchen.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

struct Kitchen: Codable {
    private var chefs: [Chef] = []
    
    mutating func addChef(_ chef: Chef) {
        chefs.append(chef)
    }
}

//
//  Kitchen.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Kitchen: Codable {
    private var chefs: [Chef] = []
    
    /// Creates `Kitchen` with empty array of `Chef`s.
    convenience init() {
        self.init(chefs: [])
    }
    
    init(chefs: [Chef]) {
        self.chefs = chefs
    }
    
    func addChef(_ chef: Chef) {
        chefs.append(chef)
    }
}

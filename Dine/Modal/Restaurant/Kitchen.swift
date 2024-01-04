//
//  Kitchen.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Kitchen {
    private var kitchenName: String
    private var chefs: [Chef]
    
    init(kitchenName: String, chefs: [Chef]) {
        self.kitchenName = kitchenName
        self.chefs = chefs
    }
}

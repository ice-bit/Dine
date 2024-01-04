//
//  Branch.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Branch {
    private var branchNAme: String
    private var location: String
    private var kitchen: Kitchen
    
    init(branchNAme: String, location: String, kitchen: Kitchen) {
        self.branchNAme = branchNAme
        self.location = location
        self.kitchen = kitchen
    }
}

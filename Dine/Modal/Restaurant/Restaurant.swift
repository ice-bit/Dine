//
//  Restaurant.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Restaurant: Codable {
    private var name: String
    private var branches: [Branch]
    
    /// Create instance of `Restaurant` with empty array of `Branch`.
    init(name: String) {
        self.name = name
        self.branches = []
    }
    
    func addBranch(_ branch: Branch) {
        branches.append(branch)
    }
}

//
//  Restaurant.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

struct Restaurant: Codable {
    private var name: String
    private var branches: [Branch]
    
    init(name: String, branches: [Branch]) {
        self.name = name
        self.branches = branches
    }
    
    mutating func addBranch(_ branch: Branch) {
        branches.append(branch)
    }
}

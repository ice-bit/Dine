//
//  TableManager.swift
//  Dine
//
//  Created by doss-zstch1212 on 30/01/24.
//

import Foundation

class TableManager: Codable {
    private var tables: [Table] = []
    
    var getTables: [Table] {
        return tables
    }
    
    func addTable(_ table: Table) {
        tables.append(table)
    }
    
}

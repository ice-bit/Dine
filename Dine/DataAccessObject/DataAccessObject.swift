//
//  DAO.swift
//  Dine
//
//  Created by doss-zstch1212 on 05/03/24.
//

import Foundation

protocol DataAccessObject {
    associatedtype Entity
    
    func add(_ entity: Entity)
    func get() -> [Entity]
    func update(_ entity: Entity) throws
    func delete(_ entity: Entity) throws
    func save(to file: Filename, entity: CSVWritable)
}

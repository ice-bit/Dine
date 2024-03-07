//
//  DAO.swift
//  Dine
//
//  Created by doss-zstch1212 on 05/03/24.
//

import Foundation

protocol DataAccessObject{
    associatedtype Entity
    
    func add(_ entity: Entity) async throws
    func get() async throws -> [Entity]
    func update(_ entity: Entity) async throws
    func delete(_ entity: Entity) async throws
}

//
//  InMemoryDAO.swift
//  Dine
//
//  Created by doss-zstch1212 on 06/03/24.
//

import Foundation

struct InMemoryDAO<Entity>: DataAccessObject {
    private var entities: [Entity] = []
    
    func add(_ entity: Entity) async throws {
        entities.append(object)
    }
    
    func get() async throws -> [Entity] {
        return entities
    }
    
    func update(_ entity: Entity) async throws {
//        if let index = entities.firstIndex(where: { $0.id  == entity.id }) {
//            
//        }
    }
    
    func delete(_ entity: Entity) async throws {
        
    }
}

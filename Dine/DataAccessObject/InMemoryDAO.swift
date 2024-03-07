//
//  InMemoryDAO.swift
//  Dine
//
//  Created by doss-zstch1212 on 06/03/24.
//

import Foundation

class InMemoryDAO<Entity: Equatable>: DataAccessObject {
    private var entities = [Entity]()
    func add(_ entity: Entity) {
        entities.append(entity)
    }
    
    func get() -> [Entity] {
        return entities
    }
    
    func update(_ entity: Entity) throws {
        if let index = entities.firstIndex(where: { $0 == entity }) {
            entities[index] = entity
        } else {
            throw DataAccessError.entityNotFound
        }
    }
    
    func delete(_ entity: Entity) throws {
        if let index = entities.firstIndex(where: { $0 == entity }) {
            entities.remove(at: index)
        } else {
            throw DataAccessError.entityNotFound
        }
    }
    
    func save(to file: Filename, entity: CSVWritable) {
        let csvWriter: CSVDataWritable = CSVWriter()
        Task {
            do {
                try await csvWriter.writeToCSV(into: file.rawValue, csvDataModal: entity)
            } catch is FileIOError {
                print("Documentory is unavailable or inaccessible!")
            } catch {
                print("Unknwon error: \(error)")
            }
        }
    }
}

enum DataAccessError: Error {
  case entityNotFound
}

//
//  DataService.swift
//  Dine
//
//  Created by doss-zstch1212 on 26/03/24.
//

import Foundation

protocol DataService {
    func add(_ entity: SQLInsertable) throws
    func fetch() throws -> [Parsable]?
    func update(_ entity: SQLUpdatable) throws
    func delete(_ entity: SQLDeletable) throws
}

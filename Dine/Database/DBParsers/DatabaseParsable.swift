//
//  DatabaseParsable.swift
//  Dine
//
//  Created by doss-zstch1212 on 19/03/24.
//

import Foundation

protocol DatabaseParsable {
    associatedtype ReturnType
    static func parseRow(statement: OpaquePointer?) throws -> ReturnType?
}

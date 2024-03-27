//
//  ModelJSONSerializer.swift
//  Dine
//
//  Created by doss-zstch1212 on 18/01/24.
//

import Foundation

class ModelJSONSerializer {
    func modelToJSON<T: Codable>(model: T) throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(model)
    }
}

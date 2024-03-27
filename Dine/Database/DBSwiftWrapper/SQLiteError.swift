//
//  SQLiteError.swift
//  Dine
//
//  Created by doss-zstch1212 on 14/03/24.
//

import Foundation

enum SQLiteError: Error {
    case openDatabase(message: String)
    case prepare(message: String)
    case step(message: String)
    case bind(message: String)
}

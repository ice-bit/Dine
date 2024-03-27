//
//  Query.swift
//  Dine
//
//  Created by doss-zstch1212 on 19/03/24.
//

import Foundation

protocol ColumnIdentifier: RawRepresentable & CodingKey & CaseIterable & Hashable {
    associatedtype TableType: Table
}

protocol Table {
    associatedtype Columns: ColumnIdentifier where Columns.TableType == Self
    static var tableName: String { get }
}

struct Query<T: Table> {
    private var selection: [String] = []
    private var whereClause: String?
    private var orderBys: [String] = []
    
    
}

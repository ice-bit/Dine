//
//  CSVParcable.swift
//  Dine
//
//  Created by doss-zstch1212 on 07/03/24.
//

import Foundation

protocol CSVParsable {
    associatedtype Entity: Parsable
    
    func parse(from data: [[String : String]]) -> [Entity]
}

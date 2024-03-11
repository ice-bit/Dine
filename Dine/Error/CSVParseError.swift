//
//  CSVParseError.swift
//  Dine
//
//  Created by doss-zstch1212 on 23/02/24.
//

import Foundation

enum CSVParseError: Error {
    case missingRequiredFields
    case insufficientData
    case parsingFailed
}

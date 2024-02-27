//
//  String+DateExtension.swift
//  Dine
//
//  Created by doss-zstch1212 on 27/02/24.
//

import Foundation

extension String {
    func toData(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}

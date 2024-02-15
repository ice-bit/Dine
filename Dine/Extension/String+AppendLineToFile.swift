//
//  String+AppendLineToFile.swift
//  Dine
//
//  Created by doss-zstch1212 on 14/02/24.
//

import Foundation

extension String {
    func appendLineToFile(_ path: String) throws {
        try (self + "\n").write(toFile: path, atomically: true, encoding: .utf8)
    }
}

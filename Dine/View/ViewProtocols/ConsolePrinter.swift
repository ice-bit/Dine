//
//  ConsolePrinter.swift
//  Dine
//
//  Created by doss-zstch1212 on 19/01/24.
//

import Foundation

protocol ConsolePrinter {
    func show(message: String)
}

// MARK: - Default behaviour for protocols
extension ConsolePrinter {
    func show(message: String) {
        print(message)
    }
}

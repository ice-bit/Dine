//
//  CommandLineInputHandler.swift
//  Dine
//
//  Created by doss-zstch1212 on 19/01/24.
//

import Foundation

protocol CommandLineInputHandler {
    func getInput() -> String?
}

extension CommandLineInputHandler {
    func getInput() -> String? {
        return readLine()
    }
}

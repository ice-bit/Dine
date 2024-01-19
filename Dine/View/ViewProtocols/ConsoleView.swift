//
//  ConsoleView.swift
//  Dine
//
//  Created by doss-zstch1212 on 19/01/24.
//

import Foundation

protocol ConsoleView {
    func show(message: String)
    func getInput() -> String?
}

extension ConsoleView {
    func show(message: String) {
        print(message)
    }
    
    func getInput() -> String? {
        return readLine()
    }
}

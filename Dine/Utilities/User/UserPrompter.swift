//
//  UserPrompter.swift
//  Dine
//
//  Created by doss-zstch1212 on 10/01/24.
//

import Foundation

class UserPrompter {
    static func getUserInput(prompt: String) -> String? {
        print(prompt)
        return readLine()
    }
}

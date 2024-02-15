//
//  AuthenticationError.swift
//  Dine
//
//  Created by doss-zstch1212 on 14/02/24.
//

import Foundation

enum AuthenticationError: Error {
    case invalidUsername
    case invalidPassword
    case inactiveAccount
    case userAlreadyExists
}

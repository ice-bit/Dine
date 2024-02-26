//
//  UserRepository.swift
//  Dine
//
//  Created by doss-zstch1212 on 08/02/24.
//

import Foundation

protocol UserRepository {
    func addUser(_ user: Account)
    func removeUser(_ user: Account) throws
    func checkUserPresence(username: String) -> Bool
    func searchUser(username: String) -> Account?
    func isUserActive(username: String) -> Bool
    func isManager(username: String) -> Bool
    func getAccounts() -> [Account]
}

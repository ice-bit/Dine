//
//  InMemoryUserRepository.swift
//  Dine
//
//  Created by doss-zstch1212 on 08/02/24.
//

import Foundation

/*struct UserRepositoryError: Error {
    enum ErrorType {
        case userNotFound
    }
    
    let type: ErrorType
}*/
enum UserRepositoryError: Error {
    case userNotFound
}

class InMemoryUserRepository: UserRepository {
    static let shared = InMemoryUserRepository()
    
    private init() {}

    private var accounts: [Account] = [
        Account(username: "TechDev_123", password: "StrongP@ss123", accountStatus: .active, userRole: .manager
               ),
        Account(username: "qwe", password: "zxc", accountStatus: .active, userRole: .manager
               )
    ]
    
    func addUser(_ user: Account) {
        accounts.append(user)
    }
    
    func removeUser(_ user: Account) throws {
        if let index = accounts.firstIndex(where: { $0 == user }) {
            accounts.remove(at: index)
        } else {
            throw UserRepositoryError.userNotFound
        }
    }
    
    func checkUserPresence(username: String) -> Bool {
        return accounts.contains(where: { $0.username == username })
    }
    
    func searchUser(username: String) -> Account? {
        return accounts.first(where: { $0.username == username })
    }
    
    func isUserActive(username: String) -> Bool {
        guard let user = searchUser(username: username) else { return false }
        return user.accountStatus == .active
    }
    
    func isManager(username: String) -> Bool {
        guard let user = searchUser(username: username) else { return false }
        return user.userRole == .manager
    }
    
    
}

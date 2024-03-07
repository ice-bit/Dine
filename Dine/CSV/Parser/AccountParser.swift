//
//  AccountParser.swift
//  Dine
//
//  Created by doss-zstch1212 on 07/03/24.
//

import Foundation

struct AccountParser: CSVParsable {
    typealias Entity = Account
    
    func parse(from data: [[String : String]]) -> [Account] {
        data.compactMap(parseAccount)
    }
    
    private func parseAccount(from userData: [String: String]) -> Account? {
        guard let userIdString = userData["userId"],
            !userIdString.isEmpty,
            let userId = UUID(uuidString: userIdString),
            let username = userData["username"],
            let password = userData["password"],
            let accountStatusString = userData["accountStatus"],
            let accountStatus = AccountStatus(rawValue: accountStatusString),
            let userRoleString = userData["userRole"],
            let userRole = UserRole(rawValue: userRoleString) else {
            return nil
        }

        return Account(userId: userId, username: username, password: password, accountStatus: accountStatus, userRole: userRole)
    }
}

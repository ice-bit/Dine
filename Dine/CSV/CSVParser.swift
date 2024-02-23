//
//  CSVParser.swift
//  Dine
//
//  Created by doss-zstch1212 on 23/02/24.
//

import Foundation

struct CSVParser {
    func parseAccounts(from data: [[String: String]]) -> [Account] {
        return data.compactMap(parseAccount)
    }

    private func parseAccount(from userData: [String: String]) -> Account? {
        guard
            let userIdString = userData["userId"],
            !userIdString.isEmpty,
            let userId = UUID(uuidString: userIdString),
            let username = userData["username"],
            let password = userData["password"],
            let accountStatusString = userData["accountStatus"],
            let accountStatus = AccountStatus(rawValue: accountStatusString),
            let userRoleString = userData["userRole"],
            let userRole = UserRole(rawValue: userRoleString)
        else {
            return nil
        }

        return Account(userId: userId, username: username, password: password, accountStatus: accountStatus, userRole: userRole)
    }
}

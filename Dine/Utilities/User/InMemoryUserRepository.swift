//
//  InMemoryUserRepository.swift
//  Dine
//
//  Created by doss-zstch1212 on 08/02/24.
//

import Foundation

@frozen enum FileName: String {
    case account = "Test_Account"
    case table = "Test_Table"
}

enum UserRepositoryError: Error {
    case userNotFound
}

class InMemoryUserRepository: UserRepository {
    static let shared = InMemoryUserRepository()
    
    private init() {
        retrieveAccounts()
    }
    
    private var accounts: [Account] = []
    
    func addUser(_ user: Account) {
        accounts.append(user)
        saveAccounts()
    }
    
    func removeUser(_ user: Account) throws {
        if let index = accounts.firstIndex(where: { $0 == user }) {
            accounts.remove(at: index)
            saveAccounts()
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
    
    func getAccounts() -> [Account] {
        return accounts
    }
    
    private func saveAccounts() {
        let fileName = FileName.account.rawValue
        let csvWriter = CSVWriter(fileName: fileName)
        do {
            let isSuccess = try csvWriter.writeToCSV(csvDataModal: self)
            print("\(isSuccess)")
        } catch {
            print("Error: \(error)!")
        }
    }
    
    private func retrieveAccounts() {
        let csvReader = CSVReader()
        let csvParser = CSVParser()
        do {
            let accountData = try csvReader.readCSV(from: FileName.account.rawValue)
            accounts = csvParser.parseAccounts(from: accountData)
        } catch {
            print("Error: \(error)")
        }
    }
}

extension InMemoryUserRepository: CSVWritable {
    func toCSVString() -> String {
        var csvString = "userId,username,password,accountStatus,userRole"
        for (index, account) in self.accounts.enumerated() {
            let row = account.toCSVString()
            
            // Append a new line if it's not the last account
            if index != self.accounts.count {
                csvString.append("\n")
            }
            
            csvString.append(row)
        }
        
        return csvString
    }
}

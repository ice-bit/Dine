//
//  CSVReader.swift
//  Dine
//
//  Created by doss-zstch1212 on 23/02/24.
//

///Shuffling of the dictionaries in your `csvData` array occurs because dictionaries in Swift, and generally in
/// programming, are unordered collections. This means the order of key-value pairs within a dictionary isn't
/// guaranteed to match the order in which they were added.

import Foundation

struct CSVReader {
    func transformContents(from fileName: String) throws -> [[String: String]] {
        guard let contents = try retrieveContents(of: fileName) else {
            throw FileIOError.documentDirectoryUnavailable
        }
        
        var csvData: [[String: String]] = []
        
        let rows: [String] = contents.components(separatedBy: "\n")
        let headerComponents: [String] = rows[0].components(separatedBy: ",")
        
        for row in rows.dropFirst() {
            var rowData = [String: String]()
            let columnComponents: [String] = row.components(separatedBy: ",")
            for (index, columnComponent) in columnComponents.enumerated() {
                rowData[headerComponents[index]] = columnComponent
            }
            csvData.append(rowData)
        }
        
        return csvData
    }
    
    func retrieveContents(of fileName: String) throws -> String? {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw FileIOError.documentDirectoryUnavailable
        }
        
        let fileURL = documentDirectory.appending(path: "\(fileName).csv")
        
        do {
            let contents = try String(contentsOf: fileURL)
            return contents
        } catch {
            print("Error reading file: \(error)")
            return nil
        }
    }
}

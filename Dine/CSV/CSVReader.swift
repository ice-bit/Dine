//
//  CSVReader.swift
//  Dine
//
//  Created by doss-zstch1212 on 23/02/24.
//

/// Shuffling of the dictionaries in your `csvData` array occurs because dictionaries in Swift, and generally in
/// programming, are unordered collections. This means the order of key-value pairs within a dictionary isn't
/// guaranteed to match the order in which they were added.

import Foundation

enum CSVReaderError: Error {
    case fileNotFound
    case fileReadError
    case invalidCSVFormat
}

struct CSVReader {
    func readCSV(from fileName: String) throws -> [[String: String]] {
        let fileURL = try getCSVFileURL(fileName)
        let contents = try String(contentsOf: fileURL)
        let csvData = try parseCSV(contents)
        return csvData
    }
    
    private func getCSVFileURL(_ fileName: String) throws -> URL {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw FileIOError.documentDirectoryUnavailable
        }
        
        let fileURL = documentDirectory.appendingPathComponent("\(fileName).csv")
        
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            // File doesn't exist, create it
            try "".write(to: fileURL, atomically: true, encoding: .utf8)
            return fileURL
        }
        
        return fileURL
    }
    
    private func parseCSV(_ contents: String) throws -> [[String: String]] {
        var csvData: [[String: String]] = []
        let rows = contents.components(separatedBy: "\n")
        
        guard let headerRow = rows.first else {
            throw CSVReaderError.invalidCSVFormat
        }
        let headerComponents = headerRow.components(separatedBy: ",")
        
        for row in rows.dropFirst() {
            var rowData = [String: String]()
            let columnComponents = row.components(separatedBy: ",")
            for (index, columnComponent) in columnComponents.enumerated() {
                if index < headerComponents.count {
                    rowData[headerComponents[index]] = columnComponent
                }
            }
            csvData.append(rowData)
        }
        
        return csvData
    }
}


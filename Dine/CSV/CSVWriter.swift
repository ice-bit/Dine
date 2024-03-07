//
//  CSVWriter.swift
//  Dine
//
//  Created by doss-zstch1212 on 23/02/24.
//

import Foundation

protocol CSVDataWritable {
    func writeToCSV(into fileName: String, csvDataModal data: CSVWritable) async throws
}

struct CSVWriter: CSVDataWritable {
    func writeToCSV(into fileName: String, csvDataModal data: CSVWritable) async throws {
        let fileManager = FileManager.default
        
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw FileIOError.documentDirectoryUnavailable
        }
        
        let fileURL = documentDirectory.appending(path: "\(fileName).csv")
        
        let csvString = data.toCSVString()
        
        do {
            try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
            print("Saved to \(fileName).csv")
            print("File URL: \(fileURL)")
        } catch {
            print("Error writing CSV file:", error)
        }
    }
}

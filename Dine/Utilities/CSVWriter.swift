//
//  CSVWriter.swift
//  Dine
//
//  Created by doss-zstch1212 on 14/02/24.
//

import Foundation

struct CSVWriter {
    func writeToCSVFile(_ csvModal: CSVExportable, fileName: String) throws {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw FileIOError.documentDirectoryUnavailable
        }
        
        let fileURL = documentDirectory.appending(path: "\(fileName).csv")
        let fileManager = FileManager.default
        let csvString = csvModal.toCSVString()
        
        if fileManager.fileExists(atPath: fileURL.absoluteString) {
            // Delete existing file before writing new data
            try fileManager.removeItem(at: fileURL)
        }
        
        
        // Append the CSV data to the file
        try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
        print("CSV file created at: \(fileURL.path)")
    }
}

//
//  FileIOController.swift
//  Dine
//
//  Created by doss-zstch1212 on 12/01/24.
//

import Foundation

enum FileOperationError: Error {
    case permissionDenied
    case fileNotFound
    case fileAlreadyExists
    case invalidFileURL
    case encodingError
    case decodingError
    case documentDirectoryUnavailable
}

struct FileIOController {
    func writeFile(content: String, fileName: String) {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appending(path: fileName)
            
            do {
                try content.write(to: fileURL, atomically: false, encoding: .utf8)
                print("File \(fileName) has been written successfully.")
            } catch let error as FileOperationError {
                handleFileError(error)
            } catch {
                print("Error writing file: \(error)")
            }
        }
    }
    
    func readFile(fileName: String) -> String? {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appending(path: fileName)
            
            do {
                let content = try String(contentsOf: fileURL, encoding: .utf8)
                return content
            } catch let error as FileOperationError {
                handleFileError(error)
                return nil
            } catch {
                print("Error reading file: \(error)")
                return nil
            }
        }
        return nil
    }
    
    func handleFileError(_ error: FileOperationError) {
        switch error {
        case .permissionDenied:
            print("Permission denied. Unable to perform file operation.")
        case .fileNotFound:
            print("File not found.")
        case .fileAlreadyExists:
            print("File with the same name already exists.")
        case .invalidFileURL:
            print("Invalid file URL.")
        case .encodingError:
            print("Error encoding file content.")
        case .decodingError:
            print("Error decoding file content.")
        case .documentDirectoryUnavailable:
            print("Unable to access the document directory.")
        }
    }
}

//
//  FileIOController.swift
//  Dine
//
//  Created by doss-zstch1212 on 12/01/24.
//

import Foundation

/// Enumeration representing possible errors related to file input and output operations.
/// - `permissionDenied`: The operation failed due to insufficient permissions.
/// - `fileNotFound`: The specified file could not be found.
/// - `fileAlreadyExists`: Attempted to create a file that already exists.
/// - `invalidFileURL`: The provided file URL is considered invalid.
/// - `encodingError`: An error occurred while encoding data.
/// - `decodingError`: An error occurred while decoding data.
/// - `documentDirectoryUnavailable`: The document directory, a common location for file operations,
///    is not available.
/// - `writeError(originalError)`: An error occurred during a write operation.
///    - Parameter originalError: The underlying error that occurred during the write operation.
/// - `readError(originalError)`: An error occurred during a read operation.
///    - Parameter originalError: The underlying error that occurred during the read operation.
enum FileIOError: Error {
    case permissionDenied
    case fileNotFound
    case fileAlreadyExists
    case invalidFileURL
    case encodingError
    case decodingError
    case documentDirectoryUnavailable
    case writeError(Error)
    case readError(Error)
}

class FileIOService {
    func write(data: Data, into fileName: String) throws {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw FileIOError.documentDirectoryUnavailable
        }
        
        let fileURL = documentDirectory.appending(path: fileName)
        
        do {
            try data.write(to: fileURL)
            print("Data written to \(fileName) successfully!")
        } catch {
            print("Error writing JSON to file: \(error)")
            throw FileIOError.writeError(error)
        }
    }
    
    func read<T: Codable>(from fileName: String) throws -> T {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw FileIOError.documentDirectoryUnavailable
        }
        
        let fileURL = documentDirectory.appending(path: fileName)
        
        do {
            let savedJSONData = try Data(contentsOf: fileURL)
            let modal = try JSONDecoder().decode(T.self, from: savedJSONData)
            return modal
        } catch {
            print("Error decoding JSON: \(error)")
            throw FileIOError.readError(error)
        }
    }
    
    private func handleFileError(_ error: FileIOError) {
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
        case .writeError(_):
            print("Error encountered while writing: \(error).")
        case .readError(_):
            print("Error encountered while reading: \(error)")
        }
    }
}

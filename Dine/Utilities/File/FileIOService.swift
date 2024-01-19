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
/// - `writeError`: An error occurred while writing to a file, encapsulating the specific error.
/// - `readError`: An error occurred while reading from a file, encapsulating the specific error.
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
    func write(data: Data, into fileName: String, completion: @escaping (Result<Void, FileIOError>) -> Void)  {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion(.failure(.documentDirectoryUnavailable))
            return
        }
        
        let fileURL = documentDirectory.appending(path: fileName)
        
        do {
            try data.write(to: fileURL)
            completion(.success(()))
            print("Data written to \(fileName) successfully!")
        } catch {
            print("Error writing JSON to file: \(error)")
            completion(.failure(.writeError(error)))
        }
    }
    
    func read<T: Codable>(from fileName: String, completion: (Result<T?, FileIOError>) -> Void) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion(.failure(.documentDirectoryUnavailable))
            return
        }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            let savedJSONData = try Data(contentsOf: fileURL)
            let modal = try JSONDecoder().decode(T.self, from: savedJSONData)
            completion(.success(modal))
        } catch CocoaError.fileReadNoSuchFile {
            // File doesn't exist, return nil or handle accordingly
            completion(.failure(.fileNotFound))
        } catch {
            print("Error decoding JSON: \(error)")
            completion(.failure(.readError(error)))
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

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
    }*/
    
    /// Saves Codable data to a file in the document directory.
    /// - Parameters:
    ///   - data: The Codable data to be saved.
    ///   - fileName: The name of the file to which the data will be saved.
    /// - Returns: `true` if the data is successfully saved, `false` otherwise.
    /// - Throws: An error if there's an issue encoding or writing the data to the file.
    static func saveDataToFile<T: Codable>(data: T, fileName: String) -> Bool {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(data)
            if let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: fileName) {
                try encodedData.write(to: filePath)
                return true
            }
        } catch {
            print("Error saving data to file: \(error)")
        }
        
        return false
    }
    
    /**
     Reads Codable data from a JSON file in the app's document directory.

     - Parameters:
        - dataType: The type of the Codable data to be retrieved.
        - fileName: The name of the file (including extension) from which to read the data.

     - Returns:
        The decoded data of type `dataType`, or `nil` if there was an issue reading or decoding the data.

     - Throws:
        An error of type `Error` if there is an issue reading or decoding the data.

     - Important:
        This function assumes that the data type `T` conforms to the `Codable` protocol.

     - Note:
        The file should be located in the app's document directory.
        Example usage:
        ```
        if let user: User = try? readDataFromFile(fileName: "userData.json") {
            print("User data retrieved: \(user)")
        }
        ```

     - SeeAlso:
        `Codable` protocol for data encoding and decoding.
        `FileManager` for accessing file system locations.
     */
    static func readDataFromFile<T: Codable>(fileName: String) throws -> T? {
        do {
            if let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: fileName) {
                let fileData = try Data(contentsOf: filePath)
                
                // Decode
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: fileData)
                
                return decodedData
            }
        } catch {
            throw error
        }
        
        return nil
    }
    
    
    /// Check if a file with a given name exists in the app's Document directory.
    /// - Parameter fileName: The name of the file (including extension) to check.
    /// - Returns: `true` if the file exists, `false` otherwise.
    static func fileExists(withName fileName: String) -> Bool {
        let fileManager = FileManager.default
        guard let filePath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(path: fileName).absoluteString else { return false }
        
        return fileManager.fileExists(atPath: filePath)
    }
}

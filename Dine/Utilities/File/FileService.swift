//
//  FileService.swift
//  Dine
//
//  Created by doss-zstch1212 on 19/01/24.
//

import Foundation

class FileService {
    func isFileAvailable(atPath path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    
    /// Checks if a file with the specified name exists in the document directory.
    /// - Parameter fileName: The name of the file to check for existence.
    /// - Returns: `true` if the file exists, `false` otherwise.
    func doesFileExistInDocumentDirectory(fileName: String) -> Bool {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return false
        }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        return FileManager.default.fileExists(atPath: fileURL.path)
    }
    
    /// Saves a Codable modal object to a JSON file asynchronously.
    /// - Parameters:
    ///   - modal: The Codable modal object to be saved.
    ///   - fileName: The name of the file (without extension) where the modal object will be saved.
    ///   - completion: A completion handler that is called after the write operation is completed. It provides a Result enum with a success case (`Void`) on successful write and a failure case (`FileIOError`) if an error occurs during the process.
    func saveModal<T: Codable>(_ modal: T, fileName: String, completion: @escaping (Result<Void, FileIOError>) -> Void) {
        let fileIO = FileIOService()
        let modalJSONSerializer = ModelJSONSerializer()
        do {
            let data = try modalJSONSerializer.modelToJSON(model: modal)
            fileIO.write(data: data, into: "\(fileName).json") { result in
                switch result {
                case .success:
                    print("Successfully written to file: \(fileName)")
                    completion(.success(()))
                case .failure(let error):
                    print("Failed to perform write: \(error)")
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(.encodingError))
        }
    }
    
    /// Saves a Codable modal object to a JSON file synchronously.
    /// - Parameters:
    ///   - modal: The Codable modal object to be saved.
    ///   - fileName: The name of the file (without extension) where the modal object will be
    /// - Throws: A `FileIOError.encodingError` if an error occurs during the encoding or writing process.
    func saveModal<T: Codable>(_ modal: T, fileName: String) throws {
        let fileIO = FileIOService()
        let modalJSONSerializer = ModelJSONSerializer()
        do {
            let data = try modalJSONSerializer.modelToJSON(model: modal)
            fileIO.write(data: data, into: "\(fileName).json") { result in
                switch result {
                case .success:
                    print("Successfully written to file: \(fileName)")
                case .failure(let error):
                    print("Failed to perform write: \(error)")
                }
            }
        } catch {
            throw FileIOError.encodingError
        }
    }
}

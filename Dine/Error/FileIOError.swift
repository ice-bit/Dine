//
//  FileIOError.swift
//  Dine
//
//  Created by doss-zstch1212 on 22/02/24.
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
    case fileCreationFailed
    case fileReadError
    case noDataAvailable
}

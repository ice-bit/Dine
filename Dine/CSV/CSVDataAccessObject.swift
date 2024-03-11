//
//  CSVDataAccessObject.swift
//  Dine
//
//  Created by doss-zstch1212 on 07/03/24.
//

import Foundation

protocol CSVPersistable {
    func save(to file: Filename, entity: CSVWritable) async
}

struct CSVDataAccessObject: CSVPersistable {
    func save(to file: Filename, entity: CSVWritable) /*async*/ {
        let csvWriter: CSVDataWritable = CSVWriter()
        do {
            try /*await*/ csvWriter.writeToCSV(into: file.rawValue, csvDataModal: entity)
        } catch is FileIOError {
            print("Documentory is unavailable or inaccessible!")
        } catch {
            print("Unknwon error: \(error)")
        }
    }
    
    func load(from file: Filename, parser: any CSVParsable) /*async*/ -> [Parsable]? {
        let csvReader = CSVReader()
        do {
            let data = try /*await*/ csvReader.readCSV(from: file.rawValue)
            return parser.parse(from: data)
        } catch is CSVReaderError {
            print("Invalid header format!")
        } catch is FileIOError {
            print("Document directory not found!")
        } catch {
            print("Unknown error: \(error)")
        }
        
        return nil
    }
}

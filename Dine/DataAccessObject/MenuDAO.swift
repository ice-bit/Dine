////
////  MenuDAO.swift
////  Dine
////
////  Created by doss-zstch1212 on 05/03/24.
////
//
//import Foundation
//
//class MenuDAO: DataAccessObject {
//    typealias T = MenuItem
//    private var menuItems = [MenuItem]()
//    
//    init() {
//        loadFromFile()
//    }
//    
//    func add(_ object: MenuItem) {
//        menuItems.append(object)
//    }
//    
//    func get() -> [MenuItem] {
//        return menuItems
//    }
//    
//    func update(_ object: MenuItem) {
//        if let index = menuItems.firstIndex(where: { $0.itemId == object.itemId }) {
//            menuItems[index] = object
////            saveToFile()
//        } else {
//            print("Item not found.")
//        }
//    }
//    
//    func delete(_ object: MenuItem) {
//        if let index = menuItems.firstIndex(where: { $0.itemId == object.itemId }) {
//            menuItems.remove(at: index)
////            saveToFile()
//        } else {
//            print("Item not found.")
//        }
//    }
//    
////    func saveToFile() {
////        let csvWriter = CSVWriter()
////        do {
////            if try csvWriter.writeToCSV(into: Filename.menuFile.rawValue, csvDataModal: "") {
////                print("SUIII!")
////            }
////        } catch {
////            print("ERROR: \(error)!")
////        }
////    }
//    
//    private func loadFromFile() {
//        let csvReader = CSVReader()
//        let csvParser = CSVParser()
//        do {
//            let data = try csvReader.readCSV(from: Filename.menuFile.rawValue)
//            menuItems = csvParser.parseMenu(from: data)
//        } catch {
//            print("ERROR: \(error)!")
//        }
//    }
//}

//
//  Menu.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Menu: Codable {
    private var _items: [MenuItem]
    
    var itemsCount: Int {
        return _items.count
    }
    
    var menuItems: [MenuItem] {
        return _items
    }
    
    /// Creates an instance of `Menu` with empty array of `MenuItem`.
    convenience init() {
        self.init(items: [])
    }
    
    init(items: [MenuItem]) {
        self._items = items
        retrieveMenuItems()
    }
    
    subscript(index: Int) -> MenuItem {
        return _items[index]
    }
    
    func displayMenuItems() {
        guard !menuItems.isEmpty else {
            print("Please add items to menu")
            return
        }
        for (index, item) in _items.enumerated() {
            print("\(index + 1). \(item.name) - $\(item.price)")
        }
    }
    
    func addItem(_ item: MenuItem) {
        _items.append(item)
        saveMenu()
    }
    
    func removeItem(_ item: MenuItem) {
        if let indexToRemove = _items.firstIndex(where: { $0.itemId == item.itemId }) {
            _items.remove(at: indexToRemove)
            print("\(item.name) removed from the menu.")
        } else {
            print("\(item.name) not found in the menu.")
        }
        
        saveMenu()
    }
    
    func retrieveMenuItems() {
        let csvReader = CSVReader()
        let csvParser = CSVParser()
        do {
            let data = try csvReader.readCSV(from: Filename.menu.rawValue)
            print("Menu data:\n\(data.description)")
            _items = csvParser.parseMenu(from: data)
            print("Items:\n\(_items.description)")
        } catch {
            print("ERROR: \(error)!")
        }
    }
    
    func saveMenu() {
        let csvWriter = CSVWriter(fileName: Filename.menu.rawValue)
        do {
            if try csvWriter.writeToCSV(csvDataModal: self) {
                print("Menu saved!")
            }
        } catch {
            print("ERROR: \(error)!")
        }
    }
}

extension Menu: CSVWritable {
    func toCSVString() -> String {
        var csvString = "itemId,name,price"
        for (index, menuItem) in _items.enumerated() {
            if index != self._items.count {
                csvString.append("\n")
            }
            
            let row = menuItem.csvString
            csvString.append(row)
        }
        
        return csvString
    }
}

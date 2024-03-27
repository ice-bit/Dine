//
//  Menu.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

/*import Foundation

class Menu {
    private var items: [MenuItem]
    init(items: [MenuItem]) {
        self.items = items
    }
    subscript(index: Int) -> MenuItem {
        return items[index]
    }
    var itemsCount: Int {
        return items.count
    }
    var menuItems: [MenuItem] {
        return items
    }
    func displayMenuItems() {
        guard !menuItems.isEmpty else {
            print("Please add items to menu")
            return
        }
        for (index, item) in items.enumerated() {
            print("\(index + 1). \(item.name) - $\(item.price)")
        }
    }
    func addItem(_ item: MenuItem) {
        items.append(item)
    }
    func removeItem(_ item: MenuItem) {
        if let indexToRemove = items.firstIndex(where: { $0.itemId == item.itemId }) {
            items.remove(at: indexToRemove)
            print("\(item.name) removed from the menu.")
        } else {
            print("\(item.name) not found in the menu.")
        }
        
        saveMenu()
    }
    
    func fetchMenuItem(with uuid: UUID) -> MenuItem? {
        guard let menuItem = menuItems.first(where: { $0.itemId == uuid }) else { return nil }
        return menuItem
    }
    
    func saveMenu() {
        Task {
            let csvDAO = CSVDataAccessObject()
            await csvDAO.save(to: .menuFile, entity: self)
        }
    }
    
    func loadMenu() {
//        Task {
            let csvDAO = CSVDataAccessObject()
            if let menuItems = /*await*/ csvDAO.load(from: .menuFile, parser: MenuParser()) as? [MenuItem] {
                self.items = menuItems
            }
//        }
    }
}

extension Menu: CSVWritable {
    func toCSVString() -> String {
        var csvString = "itemId,name,price"
        for (index, menuItem) in items.enumerated() {
            if index != self.items.count {
                csvString.append("\n")
            }
            
//            let row = menuItem.csvString
//            csvString.append(row) 
        }
        
        return csvString
    }
}*/

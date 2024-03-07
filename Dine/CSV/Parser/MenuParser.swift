//
//  MenuParser.swift
//  Dine
//
//  Created by doss-zstch1212 on 07/03/24.
//

import Foundation

struct MenuParser: CSVParsable {
    typealias Entity = MenuItem
    
    func parse(from data: [[String : String]]) -> [MenuItem] {
        data.compactMap(parseMenuItem)
    }
    
    private func parseMenuItem(from menuData: [String: String]) -> MenuItem? {
        guard let itemUUIDString = menuData["itemId"],
              let itemId = UUID(uuidString: itemUUIDString),
              let name = menuData["name"],
              let priceString = menuData["price"],
              let price = Double(priceString) else {
            return nil
        }
        
        return MenuItem(itemId: itemId, name: name, price: price)
    }
}

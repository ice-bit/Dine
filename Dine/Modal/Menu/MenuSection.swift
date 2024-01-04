//
//  MenuSection.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class MenuSection {
    private var menuSectionId: Int
    private var title: String
    private var description: String
    
    init(menuSectionId: Int, title: String, description: String) {
        self.menuSectionId = menuSectionId
        self.title = title
        self.description = description
    }
}

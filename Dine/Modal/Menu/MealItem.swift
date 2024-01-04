//
//  MealItem.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class MealItem {
    private var mealItemId: Int
    private var quantity: Int
    
    init(mealItemId: Int, quantity: Int) {
        self.mealItemId = mealItemId
        self.quantity = quantity
    }
}

//
//  Meal.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

import Foundation

class Meal {
    private var mealId: Int
    private var mealItems: [MealItem]
    
    init(mealId: Int, mealItems: [MealItem]) {
        self.mealId = mealId
        self.mealItems = mealItems
    }
}

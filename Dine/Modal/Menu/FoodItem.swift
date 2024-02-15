//
//  FoodItem.swift
//  Dine
//
//  Created by doss-zstch1212 on 11/01/24.
//

import Foundation

enum FoodItem {
    case pizza
    case burger
    case sushi
    case pasta
    case iceCream
    case salad
    case steak
    case tacos
    case pancakes
    case curry

    var name: String {
        switch self {
        case .pizza: return "Margherita Pizza"
        case .burger: return "Classic Burger"
        case .sushi: return "Sashimi Platter"
        case .pasta: return "Spaghetti Bolognese"
        case .iceCream: return "Chocolate Ice Cream"
        case .salad: return "Caesar Salad"
        case .steak: return "Filet Mignon"
        case .tacos: return "Chicken Tacos"
        case .pancakes: return "Blueberry Pancakes"
        case .curry: return "Chicken Curry"
        }
    }

    var description: String {
        switch self {
        case .pizza: return "Traditional Italian pizza with tomato and mozzarella."
        case .burger: return "Juicy beef patty with lettuce, tomato, and cheese in a sesame bun."
        case .sushi: return "Assorted slices of fresh raw fish."
        case .pasta: return "Al dente spaghetti with rich meat sauce."
        case .iceCream: return "Creamy chocolate ice cream with swirls of fudge."
        case .salad: return "Crisp romaine lettuce with Caesar dressing and croutons."
        case .steak: return "Tender filet mignon cooked to perfection."
        case .tacos: return "Soft tortillas filled with seasoned chicken and toppings."
        case .pancakes: return "Fluffy pancakes with blueberries and maple syrup."
        case .curry: return "Spicy chicken curry with aromatic herbs and spices."
        }
    }

    var price: Double {
        // You can set the prices as needed for your restaurant
        switch self {
        case .pizza, .burger, .sushi, .pasta: return 12.99
        case .iceCream, .salad, .tacos, .curry: return 8.99
        case .steak, .pancakes: return 15.99
        }
    }
}


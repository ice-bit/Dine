//
//  Stash.swift
//  Dine
//
//  Created by doss-zstch1212 on 28/02/24.
//

func getMenu() -> Menu {
    let menuItems: [MenuItem] = [
        MenuItem(name: "Burger", price: 9.99),
        MenuItem(name: "Pizza", price: 12.99),
        MenuItem(name: "Salad", price: 7.49),
        MenuItem(name: "Pasta", price: 10.99),
        MenuItem(name: "Steak", price: 15.99),
        MenuItem(name: "Sushi", price: 18.49),
        MenuItem(name: "Sandwich", price: 8.99),
        MenuItem(name: "Soup", price: 6.99),
        MenuItem(name: "Fish and Chips", price: 11.99),
        MenuItem(name: "Tacos", price: 9.49),
        MenuItem(name: "Chicken Curry", price: 13.99),
        MenuItem(name: "Burrito", price: 10.49),
        MenuItem(name: "Fried Rice", price: 8.49),
        MenuItem(name: "Caesar Salad", price: 7.99),
        MenuItem(name: "Hot Dog", price: 5.99),
        MenuItem(name: "Nachos", price: 9.99),
        MenuItem(name: "Quesadilla", price: 8.49),
        MenuItem(name: "Shrimp Scampi", price: 14.99),
        MenuItem(name: "Calzone", price: 11.49),
        MenuItem(name: "Chicken Wings", price: 9.99)
    ]
    
    return Menu.shared
}

//
//  main.swift
//  Dine
//
//  Created by doss-zstch1212 on 04/01/24.
//

// username: TechDev_123
// TechDev768
// password: StrongP@ss123

import Foundation

class Main {
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
    
    let testMenu: [MenuItem] = [
        MenuItem(name: "Shrimp Scampi", price: 14.99),
        MenuItem(name: "Calzone", price: 11.49),
        MenuItem(name: "Chicken Wings", price: 9.99)
    ]
    
    let table1 = Table(status: .free, maxCapacity: 4, locationIdentifier: 101)
    let table2 = Table(status: .occupied, maxCapacity: 6, locationIdentifier: 102)
    let table3 = Table(status: .free, maxCapacity: 2, locationIdentifier: 103)

    
    
    let orderManager = OrderManager()
    let billManager = BillManager()
    
    
    
    
    func testHomeMenu() {
        let menu = Menu(items: menuItems)
        
        let order = Order(table: Table(status: .occupied, maxCapacity: 10, locationIdentifier: 01), orderStatus: .preparing, menuItems: menuItems)
        let order2 = Order(table: Table(status: .occupied, maxCapacity: 10, locationIdentifier: 01), orderStatus: .received, menuItems: menuItems)
        
        let testBranch = Branch(branchName: "KFC UK", location: "London, UK")
        
        let restaurant = Restaurant(name: "KFC", branches: [testBranch])
        
        orderManager.addOrder(order: order)
        orderManager.addOrder(order: order2)
        
        let homeConsoleView = HomeConsoleView(branch: testBranch)
        homeConsoleView.displayHomeOptions()
    }
    
    func testChef() {
        let menu = Menu(items: menuItems)
        
        let order = Order(table: Table(status: .occupied, maxCapacity: 10, locationIdentifier: 01), orderStatus: .received, menuItems: testMenu)
        let order2 = Order(table: Table(status: .occupied, maxCapacity: 10, locationIdentifier: 01), orderStatus: .received, menuItems: menuItems)
        
        let testBranch = Branch(branchName: "KFC UK", location: "London, UK")
        
        let restaurant = Restaurant(name: "KFC", branches: [testBranch])
                                                   
        orderManager.addOrder(order: order)
        //orderManager.addOrder(order: order2)
        
        let chefView = ChefConsoleView(branch: testBranch)
        chefView.manageReceivedOrders()
    }
    
    func testAdminControls() {
        
    }
}

let main = Main()
main.testChef()




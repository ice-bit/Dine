//
//  AssociationManager.swift
//  Dine
//
//  Created by doss-zstch1212 on 05/03/24.
//

/*import Foundation

struct AssociationManager {
    let orderDAO: any DataAccessObject = OrderDAO()
    let menuDAO: any DataAccessObject = MenuDAO()
    let associationDAO: any DataAccessObject = OrderMenuItemAssociationDAO()
    
    var mappedOrders = [Order]()
    var menuItems = [MenuItem]()
    
    func mapMenuItemsToOrder() {
        guard let orderDAO = orderDAO as? OrderDAO else { return }
        guard let associationDAO = associationDAO as? OrderMenuItemAssociationDAO else { return }
        
        var unmappedOrders = orderDAO.get()
        var associations = associationDAO.get()
        
        for order in unmappedOrders {
//            fetchMenuItems(for: order.orderId, from: associations)
        }
    }
    
    private func fetchMenuItem(with itemId: UUID, from items: [MenuItem]) -> MenuItem? {
        if let index = items.firstIndex(where: { $0.itemId == itemId }) {
            return items[index]
        }
    }
    
    private mutating func fetchMenuItems(for orderId: UUID, from associationData: [OrderItemAssociation]) -> [MenuItem]? {
        loadMenuItems()
        var mappedMenuItems = [MenuItem]()
        for association in associationData {
            if association.orderId == orderId {
                if let menuItem = fetchMenuItem(with: association.itemId, from: menuItems) {
                    mappedMenuItems.append(menuItem)
                }
            }
        }
    }
    
    private mutating func loadMenuItems() {
        guard let menuDAO = menuDAO as? MenuDAO else { return }
        menuItems = menuDAO.get()
    }
}*/

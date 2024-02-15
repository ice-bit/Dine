//
//  String+OrderFormatting.swift
//  Dine
//
//  Created by doss-zstch1212 on 01/02/24.
//

import Foundation

extension String {
    static func formatOrderDetails(_ order: Order) -> String {
        return """
        Order \(order.orderId) - Table \(order.tableLocationId) - Status: \(order.orderStatus)
          Items:\n\(order.orderedItems().map { " - \($0.name) - $\($0.price)" }.joined(separator: "\n"))
        """
    }
}


//
//  String+OrderFormatting.swift
//  Dine
//
//  Created by doss-zstch1212 on 06/03/24.
//

import Foundation

extension String {
    static func formatOrderDetails(_ order: Order) -> String {
        return """
        Order \(order.orderIdValue) - Status: \(order.orderStatusValue)
          Items:\n\(order.menuItems.map { " - \($0.name) - $\($0.price)" }.joined(separator: "\n"))
        """
    }
}

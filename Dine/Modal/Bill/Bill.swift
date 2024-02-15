//
//  Bill.swift
//  Dine
//
//  Created by doss-zstch1212 on 30/01/24.
//

import Foundation

class Bill: Codable {
    private var _billId: UUID
    private var amount: Double
    private var date: Date
    private var tip: Double
    private var tax: Double
    private var isPaid: Bool
    
    var billId: UUID {
        return _billId
    }
    
    init(amount: Double, tip: Double, tax: Double, isPaid: Bool) {
        self._billId = UUID()
        self.amount = amount
        self.date = Date()
        self.tip = tip
        self.tax = tax
        self.isPaid = isPaid
    }
    
    convenience init(amount: Double, tax: Double, isPaid: Bool) {
        self.init(amount: amount, tip: 0.0, tax: tax, isPaid: isPaid)
    }
}

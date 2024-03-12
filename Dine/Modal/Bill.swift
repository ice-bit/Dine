//
//  Bill.swift
//  Dine
//
//  Created by doss-zstch1212 on 30/01/24.
//

import Foundation

class Bill {
    private var _billId: UUID
    private var amount: Double
    private var date: Date
    private var tip: Double
    private var tax: Double
    private var isPaid: Bool
    
    var billId: UUID {
        return _billId
    }
    
    var csvString: String {
        "\(_billId),\(amount),\(date),\(tip),\(tax),\(isPaid)"
    }
    
    init(_billId: UUID, amount: Double, date: Date, tip: Double, tax: Double, isPaid: Bool) {
        self._billId = _billId
        self.amount = amount
        self.date = date
        self.tip = tip
        self.tax = tax
        self.isPaid = isPaid
    }
    
    convenience init(amount: Double, tip: Double, tax: Double, isPaid: Bool) {
        self.init(_billId: UUID(), amount: amount, date: Date(), tip: tip, tax: tax, isPaid: isPaid)
    }
    
    convenience init(amount: Double, tax: Double, isPaid: Bool) {
        self.init(amount: amount, tip: 0.0, tax: tax, isPaid: isPaid)
    }
    
    func displayBill() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        let paidStatus = isPaid ? "Paid" : "Unpaid"
        
        let billDetails = """
        Bill ID: \(_billId)
        Amount: \(amount)
        Date: \(formatter.string(from: date))
        Tip: \(tip)
        Tax: \(tax.rounded(.up))
        Status: \(paidStatus)
        """
        
        return billDetails
    }
}

extension Bill: Parsable {}

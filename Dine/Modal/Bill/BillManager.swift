//
//  BillManager.swift
//  Dine
//
//  Created by doss-zstch1212 on 01/02/24.
//

import Foundation

class BillManager: Codable {
    private var bills: [Bill] = []
    
    func addBill(_ bill: Bill) {
        bills.append(bill)
    }
    
    func removeBill(_ bill: Bill) {
        if let billIndex = bills.firstIndex(where: { $0.billId == bill.billId }) {
            bills.remove(at: billIndex)
        }
    }
}

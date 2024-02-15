//
//  BillManager.swift
//  Dine
//
//  Created by doss-zstch1212 on 01/02/24.
//

import Foundation

class BillManager: Codable {
    private var _bills: [Bill] = []
    
    var bills: [Bill] {
        return _bills
    }
     
    func addBill(_ bill: Bill) {
        _bills.append(bill)
    }
    
    func removeBill(_ bill: Bill) {
        if let billIndex = _bills.firstIndex(where: { $0.billId == bill.billId }) {
            _bills.remove(at: billIndex)
        }
    }
}

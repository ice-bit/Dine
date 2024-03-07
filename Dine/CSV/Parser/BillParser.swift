//
//  BillParser.swift
//  Dine
//
//  Created by doss-zstch1212 on 07/03/24.
//

import Foundation

struct BillParser: CSVParsable {
    typealias Entity = Bill
    
    func parse(from data: [[String : String]]) -> [Bill] {
        data.compactMap(parseBill)
    }
    
    private func parseBill(from billData: [String: String]) -> Bill? {
        guard let billUUIDString = billData["billId"],
              let billId = UUID(uuidString: billUUIDString),
              let amountString = billData["amount"],
              let amount = Double(amountString),
              let dateString = billData["date"],
              let date = dateString.toData(withFormat: "yyyy-MM-dd HH:mm:ss Z"),
              let tipString = billData["tip"],
              let tip = Double(tipString),
              let taxString = billData["tax"],
              let tax = Double(taxString),
              let isPaidString = billData["isPaid"],
              let isPaid = Bool(isPaidString) else {
            return nil
        }
        
        return Bill(_billId: billId, amount: amount, date: date, tip: tip, tax: tax, isPaid: isPaid)
    }
}

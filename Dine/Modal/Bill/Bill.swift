//
//  Bill.swift
//  Dine
//
//  Created by doss-zstch1212 on 30/01/24.
//

import Foundation
import SQLite3

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

extension Bill: SQLTable {
    static var createStatement: String {
        """
        CREATE TABLE \(DatabaseTables.billTable.rawValue) (
            BillID VARCHAR(32) PRIMARY KEY,
            Amount REAL NOT NULL,
            BillDate TEXT NOT NULL,
            Tip REAL,
            Tax REAL NOT NULL,
            IsBillPaid TEXT NOT NULL
        );
        """
    }
}

extension Bill: SQLUpdatable {
    var createUpdateStatement: String {
        """
        UPDATE \(DatabaseTables.billTable.rawValue)
        SET Amount = \(amount),
            Tip = \(tip),
            Tax = \(tax),
            IsBillPaid = '\(isPaid)'
        WHERE BillID = '\(billId)';
        """
    }
}

extension Bill: SQLInsertable {
    var createInsertStatement: String {
        """
        INSERT INTO \(DatabaseTables.billTable.rawValue) (BillID, Amount, BillDate, Tip, Tax, IsBillPaid)
        VALUES ('\(billId.uuidString)', \(amount), '\(date)', \(tip), \(tax), '\(isPaid)');
        """
    }
}

extension Bill: DatabaseParsable {
    static func parseRow(statement: OpaquePointer?) throws -> Bill? {
        guard let statement = statement else { return nil }
        guard let billIdCString = sqlite3_column_text(statement, 0),
              let dateCString = sqlite3_column_text(statement, 2),
              let isPaidCString = sqlite3_column_text(statement, 5) else {
            throw DatabaseError.missingRequiredValue
        }
        
        let amount = sqlite3_column_double(statement, 1)
        let tip = sqlite3_column_double(statement, 3)
        let tax = sqlite3_column_double(statement, 4)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        guard let billId = UUID(uuidString: String(cString: billIdCString)),
              let date = dateFormatter.date(from: String(cString: dateCString)),
              let isPaid = Bool(String(cString: isPaidCString)) else {
            throw DatabaseError.conversionFailed
        }
        
        let bill = Bill(_billId: billId, amount: amount, date: date, tip: tip, tax: tax, isPaid: isPaid)
        return bill
    }
}

extension Bill: SQLQueriable {
    static var createQueryStatement: String {
        "SELECT * FROM \(DatabaseTables.billTable.rawValue);"
    }
}

extension Bill: SQLDeletable {
    var createDeleteStatement: String {
        "DELETE FROM \(DatabaseTables.billTable.rawValue) WHERE BillID = '\(billId)';"
    }
}

//
//  BillManager.swift
//  Dine
//
//  Created by doss-zstch1212 on 01/02/24.
//

/*import Foundation

class BillManager {
    static let shared = BillManager()
    
    private init() {
        loadBills()
    }
    
    private var _bills: [Bill] = []
    
    var bills: [Bill] {
        return _bills
    }
     
    func addBill(_ bill: Bill) {
        _bills.append(bill)
        saveBills()
    }
    
    func removeBill(_ bill: Bill) {
        if let billIndex = _bills.firstIndex(where: { $0.billId == bill.billId }) {
            _bills.remove(at: billIndex)
        }
        saveBills()
    }
    
    func displayBills() {
        for (index, bill) in bills.enumerated() {
            print("\(index + 1) - \(bill.displayBill())\n")
        }
    }
    
    /*func retrieveBills() {
        let csvReader = CSVReader()
        let csvParser = CSVParser()
        do {
            let data = try csvReader.readCSV(from: Filename.billFile.rawValue)
//            print(data.description)
            _bills = csvParser.parseBills(from: data)
//            print(_bills.description)
        } catch {
            print("ERROR: \(error)!")
        }
    }
    
    func saveBills() {
        let csvWriter = CSVWriter()
        do {
            if try csvWriter.writeToCSV(into: Filename.billFile.rawValue, csvDataModal: self) {
                print("Successfully saved bills")
            }
        } catch {
            print("ERROR: \(error)!")
        }
    }*/
    
    func saveBills() {
//        Task {
            let csvDAO = CSVDataAccessObject()
            /*await*/ csvDAO.save(to: .billFile, entity: self)
//        }
    }
    
    func loadBills() {
//        Task {
            let csvDAO = CSVDataAccessObject()
            if let bills = /*await*/ csvDAO.load(from: .billFile, parser: BillParser()) as? [Bill] {
                _bills = bills
            }
//        }
    }
}

extension BillManager: CSVWritable {
    func toCSVString() -> String {
        var csvString = "billId,amount,date,tip,tax,isPaid"
        
        for (index, bill) in self._bills.enumerated() {
            let row = bill.csvString
            
            // Append a new line if it's not the last bill
            if index != self._bills.count {
                csvString.append("\n")
            }
            
            csvString.append(row)
        }
        
        return csvString
    }
}*/

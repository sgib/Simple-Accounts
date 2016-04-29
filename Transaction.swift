//
//  Transaction.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 25/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation
import CoreData

struct TransactionData {
    let amount: Money
    let category: TransactionCategory
    let date: TransactionDate
    let description: String?
    let type: TransactionType
}

class Transaction: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        transactionID = NSUUID().UUIDString
    }
    
    var signedAmount: Money {
        return amount * Money(short: type.sign)
    }

}

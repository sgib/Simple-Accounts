//
//  Transaction.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 25/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation
import CoreData

typealias TransactionData = (amount: Money, category: TransactionCategory, date: TransactionDate, type: TransactionType, description: String?)

class Transaction: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        transactionID = NSUUID()
    }
    
    var signedAmount: Money {
        return amount * Money(short: type.rawValue)
    }

}

//
//  AccountTransaction.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 20/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

class Transaction {
    
    var amount: Money {
        didSet {
            amount = amount.moneyRoundedToTwoDecimalPlaces()
        }
    }
    var category: TransactionCategory
    var date: NSDate
    var description: String?
    var type: TransactionType
    
    var signedAmount: Money {
        return amount * Money(integer: type.rawValue)
    }
    
    init(amount: Money, category: TransactionCategory, date: NSDate, type: TransactionType, description: String?) {
        self.amount = amount.moneyRoundedToTwoDecimalPlaces()
        self.category = category
        self.date = date
        self.description = description
        self.type = type
    }
}




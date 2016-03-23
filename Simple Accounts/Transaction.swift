//
//  AccountTransaction.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 20/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

class Transaction: Equatable {
    
    var amount: Money {
        didSet {
            amount = amount.moneyRoundedToTwoDecimalPlaces()
        }
    }
    var category: TransactionCategory
    var date: TransactionDate
    var description: String?
    var type: TransactionType
    
    var signedAmount: Money {
        return amount * Money(integer: type.rawValue)
    }
    
    init(amount: Money, category: TransactionCategory, date: TransactionDate, type: TransactionType, description: String?) {
        self.amount = amount.moneyRoundedToTwoDecimalPlaces()
        self.category = category
        self.date = date
        self.description = description
        self.type = type
    }
}

func ==(left: Transaction, right: Transaction) -> Bool {
    return left === right
}



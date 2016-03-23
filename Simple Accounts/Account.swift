//
//  Account.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 22/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

class Account {
    private var transactions: [Transaction]
    var openingBalance: Money
    var currentBalance: Money {
        return openingBalance + transactions.sumAggregate
    }
    
    init(openingBalance: Money, transactions: [Transaction] = [] ) {
        self.transactions = transactions
        self.openingBalance = openingBalance
    }
    
    func addTransaction(transaction: Transaction) {
        transactions.append(transaction)
    }
    
}
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
    
    init(openingBalance: Money, transactions: TransactionCollection = [] ) {
        self.transactions = transactions
        self.openingBalance = openingBalance
    }
    
    func addTransaction(transaction: Transaction) {
        transactions.append(transaction)
    }
    
    func transactionsForMonth(monthInDate: TransactionDate) -> TransactionCollection {
        return transactions.filter({ $0.date.compareWithMonthGranularity(monthInDate).isSame })
    }
    
    func balanceAtStartOfMonth(monthInDate: TransactionDate) -> Money {
        return openingBalance + transactions.filter({ $0.date.compareWithMonthGranularity(monthInDate).isEarlier }).sumAggregate
    }
}
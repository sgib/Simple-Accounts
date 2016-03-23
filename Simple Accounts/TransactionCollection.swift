//
//  TransactionCollection.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 23/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

typealias TransactionCollection = [Transaction]

extension Array where Element: Transaction {
    var sumIncome: Money {
        return self.filter({ $0.type == .Income }).map({ $0.amount }).reduce(Money.zero(), combine: +)
    }
    
    var sumExpenses: Money {
        return self.filter({ $0.type == .Expense }).map({ $0.amount }).reduce(Money.zero(), combine: +)
    }
    
    var sumAggregate: Money {
        return self.map({ $0.signedAmount }).reduce(Money.zero(), combine: +)
    }
}
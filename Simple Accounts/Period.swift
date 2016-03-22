//
//  Period.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 20/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

class Period {
    var transactions = [Transaction]()
    
    var income: Money {
        return Period.sumMoney(transactions.filter({ $0.type == .Income }).map({ $0.amount }))
    }
    
    var expenses: Money {
        return Period.sumMoney(transactions.filter({ $0.type == .Expense }).map({ $0.amount }))
    }
    
    var aggregate: Money {
        return Period.sumMoney(transactions.map({ $0.signedAmount }))
    }
    
    private static func sumMoney(money: [Money]) -> Money {
        return money.reduce(Money.zero(), combine: +)
    }
}




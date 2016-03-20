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
        let amounts = transactions.filter({ $0.type == .Income }).map({ $0.amount })
        return amounts.reduce(Money.zero(), combine: + )
    }
    
    var expenses: Money {
        let amounts = transactions.filter({ $0.type == .Expense }).map({ $0.amount })
        return amounts.reduce(Money.zero(), combine: + )
    }
    
    var aggregate: Money {
        return income - expenses
    }
}

func +(left: Money, right: Money) -> Money {
    return left.decimalNumberByAdding(right)
}

func -(left: Money, right: Money) -> Money {
    return left.decimalNumberBySubtracting(right)
}

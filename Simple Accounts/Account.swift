//
//  Account.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 22/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation
import CoreData

class Account {
    private let dataSource: CoreDataStack
    private let amountSumExpression = NSExpressionDescription()
    private let incomePredicate = NSPredicate(format: "type == %@", NSNumber(short: TransactionType.Income.rawValue))
    private let expensePredicate = NSPredicate(format: "type == %@", NSNumber(short: TransactionType.Expense.rawValue))
    
    var openingBalance: Money
    var currentBalance: Money {
        let totalIncome = totalOfType(.Income, usingPredicate: nil)
        let totalExpenses = totalOfType(.Expense, usingPredicate: nil)
        return openingBalance + totalIncome - totalExpenses
    }
    
    init(openingBalance: Money, dataSource: CoreDataStack ) {
        self.dataSource = dataSource
        self.openingBalance = openingBalance
        self.amountSumExpression.expression = NSExpression(forFunction: "sum:", arguments:[NSExpression(forKeyPath: "amount")])
        self.amountSumExpression.expressionResultType = .DecimalAttributeType
    }
    
    func addTransaction(transactionData: TransactionData) -> Transaction {
        //we always create new transaction rather than matching existing one
        let newTransaction = dataSource.createManagedEntity(Transaction.self)
        newTransaction.amount = transactionData.amount.moneyRoundedToTwoDecimalPlaces()
        newTransaction.category = transactionData.category
        newTransaction.date = transactionData.date
        newTransaction.transactionDescription = transactionData.description
        newTransaction.type = transactionData.type
        dataSource.saveChanges()
        return newTransaction
    }
    
    
    func transactionsForMonth(monthInDate: TransactionDate) -> TransactionCollection {
        let startDate = monthInDate.dateAtTheStartOfMonth()
        let endDate = monthInDate.dateAtTheEndOfMonth()
        let predicate = NSPredicate(format: "date >= %@ && date <= %@", startDate, endDate)
        return dataSource.fetchEntity(Transaction.self, matchingPredicate: predicate, sortedBy: nil).simpleResult()
    }
    
    func balanceAtStartOfMonth(monthInDate: TransactionDate) -> Money {
        let startDate = monthInDate.dateAtTheStartOfMonth()
        let predicate = NSPredicate(format: "date < %@", startDate)
        let totalIncomeBeforeMonth = totalOfType(.Income, usingPredicate: predicate)
        let totalExpensesBeforeMonth = totalOfType(.Expense, usingPredicate: predicate)
        return openingBalance + totalIncomeBeforeMonth - totalExpensesBeforeMonth
    }
    
    private func allTransactions() -> TransactionCollection {
        return dataSource.fetchEntity(Transaction.self, matchingPredicate: nil, sortedBy: nil).simpleResult()
    }
    
    private func totalOfType(type: TransactionType, usingPredicate predicate: NSPredicate?) -> Money {
        let typePredicate = (type == .Expense) ? expensePredicate : incomePredicate
        let predicateArray = (predicate == nil) ? [typePredicate] : [predicate!, typePredicate]
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicateArray)
        let totalSum = dataSource.fetchAggregate(Transaction.self, usingExpression: amountSumExpression, matchingPredicate: compoundPredicate)
        return Money(decimal: totalSum.decimalValue)
    }
}





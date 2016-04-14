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
    
    ///adds a new Transaction to the account with the given data and returns it.
    func addTransaction(transactionData: TransactionData) -> Transaction {
        let newTransaction = dataSource.createManagedEntity(Transaction.self)
        newTransaction.amount = transactionData.amount.moneyRoundedToTwoDecimalPlaces()
        newTransaction.category = transactionData.category
        newTransaction.date = transactionData.date
        newTransaction.transactionDescription = transactionData.description?.trim()
        newTransaction.type = transactionData.type
        dataSource.saveChanges()
        return newTransaction
    }
    
    ///saves the changes to the given transaction
    func updateTransaction(transaction: Transaction) {
        transaction.amount = transaction.amount.moneyRoundedToTwoDecimalPlaces()
        transaction.transactionDescription?.trim()
        dataSource.saveChanges()
    }
    
    ///deletes the given transaction
    func deleteTransaction(transaction: Transaction) {
        dataSource.deleteEntity(Transaction.self, matchingPredicate: NSPredicate(format: "transactionID == %@", transaction.transactionID))
        dataSource.reset()
    }
    
    func transactionsForRange(dateRange: TransactionDateRange) -> TransactionCollection {
        let dateBetweenPredicate = NSPredicate(format: "date >= %@ && date <= %@", dateRange.startDate, dateRange.endDate)
        return dataSource.fetchEntity(Transaction.self, matchingPredicate: dateBetweenPredicate, sortedBy: nil).simpleResult()
    }
    
    func balanceAtStartOfRange(dateRange: TransactionDateRange) -> Money {
        let dateBeforePredicate = NSPredicate(format: "date < %@", dateRange.startDate)
        let totalIncomeBeforeRange = totalOfType(.Income, usingPredicate: dateBeforePredicate)
        let totalExpensesBeforeRange = totalOfType(.Expense, usingPredicate: dateBeforePredicate)
        return openingBalance + totalIncomeBeforeRange - totalExpensesBeforeRange
    }
    
    private func totalOfType(type: TransactionType, usingPredicate predicate: NSPredicate?) -> Money {
        let typePredicate = (type == .Expense) ? expensePredicate : incomePredicate
        let predicateArray = (predicate == nil) ? [typePredicate] : [predicate!, typePredicate]
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicateArray)
        let totalSum = dataSource.fetchAggregate(Transaction.self, usingExpression: amountSumExpression, matchingPredicate: compoundPredicate)
        return Money(decimal: totalSum.decimalValue)
    }
}





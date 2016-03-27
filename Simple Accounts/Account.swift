//
//  Account.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 22/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

class Account {
    private let dataSource: CoreDataStack
    var openingBalance: Money
    var currentBalance: Money {
        return openingBalance + allTransactions().sumAggregate
    }
    
    init(openingBalance: Money, dataSource: CoreDataStack ) {
        self.dataSource = dataSource
        self.openingBalance = openingBalance
    }
    
    func addTransaction(transactionData: TransactionData) -> Transaction {
        //we always create new transaction rather than matching existing one
        let newTransaction = dataSource.createManagedEntity(Transaction.self)
        newTransaction.amount = transactionData.amount
        newTransaction.category = transactionData.category
        newTransaction.date = transactionData.date
        newTransaction.transactionDescription = transactionData.description
        newTransaction.type = transactionData.type
        return newTransaction
    }
    
    
    func transactionsForMonth(monthInDate: TransactionDate) -> TransactionCollection {
        let startDate = monthInDate.dateAtTheStartOfMonth()
        let endDate = monthInDate.dateAtTheEndOfMonth()
        let predicate = NSPredicate(format: "date >= %@ && date <= %@", startDate, endDate)
        return dataSource.fetchEntity(Transaction.self, matchingPredicate: predicate, sortedBy: nil).simpleResult()
        //return allTransactions().filter({ $0.date.compareTo(monthInDate, toNearest: .Month).isSame })
    }
    
    func balanceAtStartOfMonth(monthInDate: TransactionDate) -> Money {
        let startDate = monthInDate.dateAtTheStartOfMonth()
        let predicate = NSPredicate(format: "date < %@", startDate)
        return openingBalance + dataSource.fetchEntity(Transaction.self, matchingPredicate: predicate, sortedBy: nil).simpleResult().sumAggregate
        //return openingBalance + allTransactions().filter({ $0.date.compareTo(monthInDate, toNearest: .Month).isEarlier }).sumAggregate
    }
    
    private func allTransactions() -> TransactionCollection {
        return dataSource.fetchEntity(Transaction.self, matchingPredicate: nil, sortedBy: nil).simpleResult()
    }
}
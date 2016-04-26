//
//  TransactionsDataSource.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 25/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

typealias TransactionSortFunction = (Transaction, Transaction) -> Bool

class TransactionsDataSource: NSObject, UITableViewDataSource {
    
    private let reuseID = "TransactionCell"

    enum SortType {
        case amountHighToLow
        case amountLowToHigh
        case categoryAToZ
        case categoryZToA
        case dateOldestFirst
        case dateNewestFirst
        
        var sortFunction: TransactionSortFunction {
            switch self {
            case .amountHighToLow:
                return { $0.amount > $1.amount }
            case .amountLowToHigh:
                return { $0.amount < $1.amount }
            case .categoryAToZ:
                return { $0.category.name < $1.category.name }
            case .categoryZToA:
                return { $0.category.name > $1.category.name }
            case .dateOldestFirst:
                return { $0.date < $1.date }
            case .dateNewestFirst:
                return { $0.date > $1.date }
            }
        }
    }
    
    
    //MARK: - Dependencies
    
    private let account: Account
    private (set) var currentTransactions = TransactionCollection()
    var formatter: AccountsFormatter
    var sortType: SortType {
        didSet {
            sortTransactions()
        }
    }
    
    //MARK: - Functions 
    
    func loadDataForRange(dateRange: StandardTransactionDateRange) {
        currentTransactions = account.transactionsForRange(dateRange)
        sortTransactions()
    }
    
    //MARK: - Private functions
    
    private func sortTransactions() {
        currentTransactions.sortInPlace(sortType.sortFunction)
    }
    
    //MARK: - Lifecycle
    
    init(account: Account, formatter: AccountsFormatter, sortType: SortType) {
        self.account = account
        self.formatter = formatter
        self.sortType = sortType
    }
    
    //MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTransactions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseID, forIndexPath: indexPath) as! TransactionTableViewCell
        let transaction = currentTransactions[indexPath.row]
        cell.setContent(transaction, usingFormatter: formatter)
        return cell
    }
}

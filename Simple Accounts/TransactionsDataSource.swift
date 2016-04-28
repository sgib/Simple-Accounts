//
//  TransactionsDataSource.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 25/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class TransactionsDataSource: NSObject, UITableViewDataSource {
    
    private let reuseID = "TransactionCell"

    //MARK: - Dependencies
    
    private let account: Account
    private (set) var currentTransactions = TransactionCollection()
    var formatter: AccountsFormatter
    var sortType: TransactionSortType {
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
    
    init(account: Account, formatter: AccountsFormatter, sortType: TransactionSortType) {
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

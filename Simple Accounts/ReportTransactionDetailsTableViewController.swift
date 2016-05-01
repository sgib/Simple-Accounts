//
//  ReportTransactionDetailsTableViewController.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 01/05/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class ReportTransactionDetailsTableViewController: UITableViewController {
 
    private var transactionsDataSource: TransactionsDataSource!
    
    //MARK: - Dependencies
    
    var transactionData: TransactionCollection!
    var formatter: AccountsFormatter!
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        transactionsDataSource = TransactionsDataSource(formatter: formatter, sortType: .DateOldestFirst)
        transactionsDataSource.setData(transactionData)
        tableView.dataSource = transactionsDataSource
    }

}

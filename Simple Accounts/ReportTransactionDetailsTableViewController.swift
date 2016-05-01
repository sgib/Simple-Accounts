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
    private let sortOptions = TransactionSortType.amountCases + TransactionSortType.dateCases
    
    //MARK: - Dependencies
    
    var transactionData: TransactionCollection!
    var formatter: AccountsFormatter!
    
    //MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destVC = segue.destinationViewController as? SortPickerViewController {
            destVC.sortType = transactionsDataSource.sortType
            destVC.sortOptions = sortOptions
            destVC.delegate = self
        }
    }
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        transactionsDataSource = TransactionsDataSource(formatter: formatter, sortType: .DateOldestFirst)
        transactionsDataSource.setData(transactionData)
        tableView.dataSource = transactionsDataSource
    }

}

extension ReportTransactionDetailsTableViewController: TransactionSortPickerDelegate {
    func sortPicker(sortPicker: SortPickerViewController, didChangeSortTo sortType: TransactionSortType) {
        transactionsDataSource.sortType = sortType
        tableView.reloadData()
    }
}
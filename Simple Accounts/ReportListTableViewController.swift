//
//  ReportListTableViewController.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 20/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class ReportListTableViewController: UITableViewController {
    
    private let reportReuseID = "TransactionReportCell"
    private let totalReuseID = "ReportTotalCell"
    private let emptyReuseID = "ReportEmptyCell"
    private var incomeTotal: Money = Money.zero()
    private var expenseTotal: Money = Money.zero()
    private var reportData: [TransactionCollection] = []
    
    //MARK: - Dependencies
    
    var reportRange: CustomTransactionDateRange?
    var account: Account!
    var categoryStore: CategoryStore!
    var formatter: AccountsFormatter!
    
    //MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destVC = segue.destinationViewController as? ReportTransactionDetailsTableViewController {
            destVC.formatter = formatter
            destVC.transactionData = reportData[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    //MARK: - Private functions
    
    private func generateReport(range: CustomTransactionDateRange) {
        reportData = [TransactionCollection]()
        for category in categoryStore.allCategories() {
            let transactions = account.transactionsForRange(range, inCategory: category)
            if transactions.isNotEmpty {
                reportData.append(transactions)
            }
        }
        let sumAggregates = reportData.map({ $0.sumAggregate })
        incomeTotal = sumAggregates.filter({ $0.isPositive }).reduce(Money.zero(), combine: +)
        expenseTotal = sumAggregates.filter({ $0.isNegative }).reduce(Money.zero(), combine: +)
    }
    
    //MARK: - View lifecycle
    
    override func viewWillAppear(animated: Bool) {
        if let range = reportRange {
            title = "Report for \(range.displayName)"
            generateReport(range)
        } else {
            title = ""
        }
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if reportRange != nil {
            if section == 0 {
                return reportData.isNotEmpty ? reportData.count : 1
            } else {
                return reportData.isNotEmpty ? 1 : 0
            }
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if reportData.isNotEmpty {
                let cell = tableView.dequeueReusableCellWithIdentifier(reportReuseID, forIndexPath: indexPath) as! ReportTableViewCell
                let transactions = reportData[indexPath.row]
                let sumAggregate = transactions.sumAggregate
                let percentage = sumAggregate.isNegative ? sumAggregate / expenseTotal : sumAggregate / incomeTotal
                cell.setContent(transactions, percentage: percentage.doubleValue, usingFormatter: formatter)
                return cell
            } else {
                return tableView.dequeueReusableCellWithIdentifier(emptyReuseID, forIndexPath: indexPath)
            }
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(totalReuseID, forIndexPath: indexPath) as! ReportTotalTableViewCell
            cell.setContent(reportData, usingFormatter: formatter)
            return cell
        }
    }

}

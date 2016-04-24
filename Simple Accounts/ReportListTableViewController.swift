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
    
    //MARK: - Dependencies
    
    var reportData: TransactionReportData? {
        didSet {
            if let report = reportData {
                let sumAggregates = report.transactions.map({ $0.sumAggregate })
                incomeTotal = sumAggregates.filter({ $0.isPositive }).reduce(Money.zero(), combine: +)
                expenseTotal = sumAggregates.filter({ $0.isNegative }).reduce(Money.zero(), combine: +)
            }
        }
    }
    
    var formatter: AccountsFormatter!
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        if let report = reportData {
            title = "Report for \(report.range.displayName)"
        } else {
            title = ""
        }
        tableView.reloadData()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        reportData = nil
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let report = reportData {
            if section == 0 {
                return report.transactions.isNotEmpty ? report.transactions.count : 1
            } else {
                return report.transactions.isNotEmpty ? 1 : 0
            }
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if reportData!.transactions.isNotEmpty {
                let cell = tableView.dequeueReusableCellWithIdentifier(reportReuseID, forIndexPath: indexPath) as! ReportTableViewCell
                let transactions = reportData!.transactions[indexPath.row]
                let sumAggregate = transactions.sumAggregate
                let percentage = sumAggregate.isNegative ? sumAggregate / expenseTotal : sumAggregate / incomeTotal
                cell.setContent(transactions, percentage: percentage.doubleValue, usingFormatter: formatter)
                return cell
            } else {
                return tableView.dequeueReusableCellWithIdentifier(emptyReuseID, forIndexPath: indexPath)
            }
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(totalReuseID, forIndexPath: indexPath) as! ReportTotalTableViewCell
            cell.setContent(reportData!, usingFormatter: formatter)
            return cell
        }
    }

}

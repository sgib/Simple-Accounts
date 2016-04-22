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
    
    var reportData: [TransactionCollection]? {
        didSet {
            if let report = reportData {
                let sumAggregates = report.map({ $0.sumAggregate })
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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let report = reportData {
            if section == 0 {
                return report.isNotEmpty ? report.count : 1
            } else {
                return report.isNotEmpty ? 1 : 0
            }
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if reportData!.isNotEmpty {
                let cell = tableView.dequeueReusableCellWithIdentifier(reportReuseID, forIndexPath: indexPath) as! ReportTableViewCell
                let transactions = reportData![indexPath.row]
                let sumAggregate = transactions.sumAggregate
                let percentage = sumAggregate.isNegative ? sumAggregate / expenseTotal : sumAggregate / incomeTotal
                cell.setContent(transactions, percentage: percentage.doubleValue, usingFormatter: formatter)
                return cell
            } else {
                return tableView.dequeueReusableCellWithIdentifier(emptyReuseID, forIndexPath: indexPath)
            }
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(totalReuseID, forIndexPath: indexPath) as! ReportTotalTableViewCell
            let total = incomeTotal + expenseTotal
            cell.setContent(total, usingFormatter: formatter)
            return cell
        }
    }

}

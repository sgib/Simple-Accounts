//
//  ReportTotalTableViewCell.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 21/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class ReportTotalTableViewCell: UITableViewCell {

    //MARK: - Dependency function
    
    func setContent(reportData: [TransactionCollection], usingFormatter formatter: AccountsFormatter) {
        let incomeTotal = reportData.map({ $0.sumIncome }).reduce(Money.zero(), combine: +)
        let expenseTotal = reportData.map({ $0.sumExpenses }).reduce(Money.zero(), combine: -)
        let aggregateTotal = incomeTotal + expenseTotal
        
        incomeLabel.setTextToMoneyAmount(incomeTotal, usingFormatter: formatter)
        expensesLabel.setTextToMoneyAmount(expenseTotal, usingFormatter: formatter)
        totalLabel.setTextToMoneyAmount(aggregateTotal, usingFormatter: formatter)
    }
    
    //MARK: - Outlets
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var expensesLabel: UILabel!
}

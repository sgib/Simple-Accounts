//
//  ReportTableViewCell.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 21/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class ReportTableViewCell: UITableViewCell {

    //MARK: - Dependency function
    
    func setContent(transactions: TransactionCollection, percentage: Double, usingFormatter formatter: AccountsFormatter) {
        //assume transactions is not empty and all categories are the same
        let category = transactions.first!.category 
        
        categoryIconImageView.image = UIImage(named: category.icon)
        categoryNameLabel.text = category.name
        numberOfTransactionsLabel.text = "transactions: \(transactions.count)"
        sumIncomeLabel.textColor = formatter.positiveAmountColour
        sumIncomeLabel.text = formatter.currencyStringFrom(transactions.sumIncome)
        sumExpensesLabel.textColor = formatter.negativeAmountColour
        sumExpensesLabel.text = formatter.currencyStringFrom(transactions.sumExpenses)
        
        let sumAggregate = transactions.sumAggregate
        let textColour = sumAggregate.isNegative ? formatter.negativeAmountColour : formatter.positiveAmountColour
        sumAggregateLabel.textColor = textColour
        sumAggregateLabel.text = formatter.currencyStringFrom(sumAggregate.absoluteValue)
        percentageLabel.textColor = textColour
        percentageLabel.text = formatter.percentStringFrom(percentage)
    }

    //MARK: - Outlets
    
    @IBOutlet weak var categoryIconImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var numberOfTransactionsLabel: UILabel!
    @IBOutlet weak var sumIncomeLabel: UILabel!
    @IBOutlet weak var sumExpensesLabel: UILabel!
    @IBOutlet weak var sumAggregateLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
}

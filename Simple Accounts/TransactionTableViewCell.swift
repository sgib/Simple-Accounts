//
//  TransactionTableViewCell.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 11/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    private let midRedColour = UIColor(red: 0.5, green: 0, blue: 0, alpha: 1)
    private let midGreenColour = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)

    //MARK: - Dependency function
    
    func setContent(transaction: Transaction, usingFormatter formatter: AccountsFormatter) {
        categoryImageView.image = UIImage(named: transaction.category.icon)
        let unwrappedDescription: String = transaction.transactionDescription ?? ""
        if unwrappedDescription.isEmpty {
            categoryLabel.text = transaction.category.name
            descriptionLabel.text = ""
        } else {
            categoryLabel.text = ""
            descriptionLabel.text = unwrappedDescription
        }
        dateLabel.text = formatter.dateStringFrom(transaction.date)
        amountLabel.text = formatter.currencyStringFrom(transaction.amount)
        amountLabel.textColor = (transaction.type == .Expense) ? midRedColour : midGreenColour
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

}

//
//  TransactionTableViewCell.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 11/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

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
        amountLabel.setTextToMoneyAmount(transaction.signedAmount, usingFormatter: formatter)
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

}

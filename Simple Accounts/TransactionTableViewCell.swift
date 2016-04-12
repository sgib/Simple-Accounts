//
//  TransactionTableViewCell.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 11/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    //MARK: - Dependencies
    var transaction: Transaction! {
        didSet {
            categoryImageView.image = UIImage(named: transaction.category.icon)
            let unwrappedDescription: String = transaction.transactionDescription ?? ""
            if unwrappedDescription.isEmpty {
                categoryLabel.text = transaction.category.name
                descriptionLabel.text = ""
            } else {
                categoryLabel.text = ""
                descriptionLabel.text = unwrappedDescription
            }
            let formatter = NSDateFormatter()
            formatter.dateFormat = "dd MMMM yyyy"
            dateLabel.text = formatter.stringFromDate(transaction.date)
            amountLabel.text = NSNumberFormatter.localizedStringFromNumber(transaction.amount, numberStyle: .CurrencyStyle)
            amountLabel.textColor = (transaction.type == .Expense) ? UIColor.redColor() : UIColor.greenColor()
        }
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
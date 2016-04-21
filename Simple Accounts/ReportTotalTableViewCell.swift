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
    
    func setContent(amount: Money, usingFormatter formatter: AccountsFormatter) {
        totalLabel.textColor = amount.isNegative ? formatter.negativeAmountColour : formatter.positiveAmountColour
        totalLabel.text = formatter.currencyStringFrom(amount)
    }
    
    //MARK: - Outlets
    @IBOutlet weak var totalLabel: UILabel!
}

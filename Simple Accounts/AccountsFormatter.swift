//
//  AccountsFormatter.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 18/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class AccountsFormatter {
    
    private let currencyFormatter = NSNumberFormatter()
    private let dateFormatter = NSDateFormatter()
    private let percentFormatter = NSNumberFormatter()
    
    init(dateFormat: String) {
        currencyFormatter.numberStyle = .CurrencyStyle
        dateFormatter.dateFormat = dateFormat
        percentFormatter.numberStyle = .PercentStyle
        percentFormatter.minimumFractionDigits = 2
        percentFormatter.maximumFractionDigits = 2
    }
    
    let positiveAmountColour = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)
    let negativeAmountColour = UIColor(red: 0.5, green: 0, blue: 0, alpha: 1)
    
    func currencyStringFrom(money: Money) -> String {
        return currencyFormatter.stringFromNumber(money) ?? currencyFormatter.notANumberSymbol
    }
    
    func dateStringFrom(date: TransactionDate) -> String {
        return dateFormatter.stringFromDate(date)
    }
    
    func percentStringFrom(percentage: Double) -> String {
        return percentFormatter.stringFromNumber(percentage) ?? percentFormatter.notANumberSymbol
    }
}
//
//  AccountsFormatter.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 18/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

class AccountsFormatter {
    
    private let currencyFormatter = NSNumberFormatter()
    private let dateFormatter = NSDateFormatter()
    
    init(dateFormat: String) {
        currencyFormatter.numberStyle = .CurrencyStyle
        dateFormatter.dateFormat = dateFormat
    }
    
    func currencyStringFrom(money: Money) -> String {
        return currencyFormatter.stringFromNumber(money) ?? currencyFormatter.notANumberSymbol
    }
    
    func dateStringFrom(date: TransactionDate) -> String {
        return dateFormatter.stringFromDate(date)
    }
}
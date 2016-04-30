//
//  AccountSettingsProvider.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 30/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

class AccountSettingsProvider {
    private let sortTypeKey = "accountSettingsProviderSortTypeKey"
    private let dateRangeStartDateKey = "accountSettingsProviderDateRangeStartDateKey"
    private let dateRangeSizeKey = "accountSettingsProviderDateRangeSizeKey"
    
    private let defaultSortType = TransactionSortType.DateOldestFirst
    private let defaultRangeSize = StandardTransactionDateRange.Size.Month
    
    
    var transactionSortType: TransactionSortType {
        didSet {
            NSUserDefaults.standardUserDefaults().setObject(transactionSortType.rawValue, forKey: sortTypeKey)
        }
    }
    
    var transactionDateRange: StandardTransactionDateRange {
        didSet {
            NSUserDefaults.standardUserDefaults().setObject(transactionDateRange.startDate, forKey: dateRangeStartDateKey)
            NSUserDefaults.standardUserDefaults().setObject(transactionDateRange.size.rawValue, forKey: dateRangeSizeKey)
        }
    }
    
    init() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let sortTypeRawValue = defaults.stringForKey(sortTypeKey), sortType = TransactionSortType(rawValue: sortTypeRawValue) {
            transactionSortType = sortType
        } else {
            transactionSortType = defaultSortType
        }
        if let rangeSizeRawValue = defaults.stringForKey(dateRangeSizeKey),
            rangeSize = StandardTransactionDateRange.Size(rawValue: rangeSizeRawValue),
            startDate = defaults.objectForKey(dateRangeStartDateKey) as? TransactionDate {
            transactionDateRange = StandardTransactionDateRange.rangeFromDate(startDate, withSize: rangeSize)
        } else {
            transactionDateRange = StandardTransactionDateRange.rangeFromDate(TransactionDate.Today, withSize: defaultRangeSize)
        }
    }
}
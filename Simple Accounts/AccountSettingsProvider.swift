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
    private let reportDateRangeStartDateKey = "accountSettingsProviderReportDateRangeStartDateKey"
    private let reportDateRangeEndDateKey = "accountSettingsProviderReportDateRangeEndDateKey"
    
    private let defaultSortType = TransactionSortType.DateOldestFirst
    private let defaultRangeSize = StandardTransactionDateRange.Size.Month
    
    
    var transactionSortType: TransactionSortType
    var transactionDateRange: StandardTransactionDateRange
    var reportDateRange: CustomTransactionDateRange?
    
    func saveChanges() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(transactionSortType.rawValue, forKey: sortTypeKey)
        defaults.setObject(transactionDateRange.startDate, forKey: dateRangeStartDateKey)
        defaults.setObject(transactionDateRange.size.rawValue, forKey: dateRangeSizeKey)
        if let reportRange = reportDateRange {
            defaults.setObject(reportRange.startDate, forKey: reportDateRangeStartDateKey)
            defaults.setObject(reportRange.endDate, forKey: reportDateRangeEndDateKey)
        } else {
            defaults.removeObjectForKey(reportDateRangeStartDateKey)
            defaults.removeObjectForKey(reportDateRangeEndDateKey)
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
        if let reportStartDate = defaults.objectForKey(reportDateRangeStartDateKey) as? TransactionDate,
            reportEndDate = defaults.objectForKey(reportDateRangeEndDateKey) as? TransactionDate {
            reportDateRange = CustomTransactionDateRange(startDate: reportStartDate, endDate: reportEndDate)
        }
    }
}
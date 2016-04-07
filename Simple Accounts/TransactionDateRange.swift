//
//  TransactionDateRange.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 05/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

struct TransactionDateRange {
    private let size: DateRangeSize
    let startDate: TransactionDate
    let endDate: TransactionDate
    
    private init(startDate: TransactionDate, endDate: TransactionDate, size: DateRangeSize) {
        self.startDate = startDate
        self.endDate = endDate
        self.size = size
    }
    
    static func rangeFromDate(date: TransactionDate, withSize: DateRangeSize) -> TransactionDateRange {
        switch withSize {
        case .Week:
            let startDate = date.dateAtStartOfWeek()
            let endDate = date.dateAtEndOfWeek()
            return TransactionDateRange(startDate: startDate, endDate: endDate, size: .Week)
        case .Month:
            let startDate = date.dateAtStartOfMonth()
            let endDate = date.dateAtEndOfMonth()
            return TransactionDateRange(startDate: startDate, endDate: endDate, size: .Month)
        case .Year:
            let startDate = date.dateAtStartOfYear()
            let endDate = date.dateAtEndOfYear()
            return TransactionDateRange(startDate: startDate, endDate: endDate, size: .Year)
        }
    }
    
    func previous() -> TransactionDateRange {
        if size == .Week {
            return TransactionDateRange(startDate: startDate.dateByAddingDays(-7), endDate: startDate.dateByAddingDays(-1), size: .Week)
        } else {
            return TransactionDateRange.rangeFromDate(startDate.dateByAddingDays(-1), withSize: size)
        }
    }
    
    func next() -> TransactionDateRange {
        if size == .Week {
            return TransactionDateRange(startDate: endDate.dateByAddingDays(1), endDate: endDate.dateByAddingDays(7), size: .Week)
        } else {
            return TransactionDateRange.rangeFromDate(endDate.dateByAddingDays(1), withSize: size)
        }
    }
    
    var displayName: String {
        let formatter = NSDateFormatter()
        switch size {
        case .Week:
            //TODO: format week differently when it falls across year boundary and possibly also for month boundaries?
            formatter.dateFormat = "dd MMM"
            return formatter.stringFromDate(startDate) + " - " + formatter.stringFromDate(endDate)
        case .Month:
            formatter.dateFormat = "MMMM"
            let selfYear = self.startDate.year
            let currentYear = TransactionDate.Today.year
            let yearString = (selfYear == currentYear) ? "" : " \(selfYear)"
            return formatter.stringFromDate(startDate) + yearString
        case .Year:
            formatter.dateFormat = "yyyy"
            return formatter.stringFromDate(startDate)
        }
    }
}









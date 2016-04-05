//
//  TransactionDateRange.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 05/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

protocol TransactionDateRange {
    init(dateInRange: TransactionDate)
    var startDate: TransactionDate { get }
    var endDate: TransactionDate { get }
    func previous() -> TransactionDateRange
    func next() -> TransactionDateRange
    var displayName: String { get }
}

class TransactionDateRangeWeek: TransactionDateRange {
    private static let formatter: NSDateFormatter = {
        let form = NSDateFormatter()
        form.dateFormat = "dd MMM"
        return form
    }()
    let startDate: TransactionDate
    let endDate: TransactionDate
    
    required init(dateInRange: TransactionDate) {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Weekday], fromDate: dateInRange)
        let dayDifference = calendar.firstWeekday - components.weekday
        startDate = calendar.dateByAddingUnit(.Day, value: dayDifference, toDate: dateInRange, options: .MatchStrictly)!
        endDate = calendar.dateByAddingUnit(.Day, value: 6, toDate: startDate, options: .MatchStrictly)!
    }
    
    func previous() -> TransactionDateRange {
        let endOfLastWeek = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: -1, toDate: startDate, options: .MatchStrictly)!
        return TransactionDateRangeWeek(dateInRange: endOfLastWeek)
    }
    func next() -> TransactionDateRange {
        let startOfNextWeek = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: 1, toDate: endDate, options: .MatchStrictly)!
        return TransactionDateRangeWeek(dateInRange: startOfNextWeek)
    }
    
    var displayName: String {
        return TransactionDateRangeWeek.formatter.stringFromDate(startDate) + " - " + TransactionDateRangeWeek.formatter.stringFromDate(endDate)
    }
}
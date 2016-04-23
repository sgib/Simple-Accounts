//
//  CustomTransactionDateRange.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 23/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

struct CustomTransactionDateRange: DateRange {
    let startDate: TransactionDate
    let endDate: TransactionDate
    
    var displayName: String {
        let startDateFormatter = NSDateFormatter()
        let endDateFormatter = NSDateFormatter()
        endDateFormatter.dateFormat = "dd MMMM yyyy"
        
        if startDate.year == endDate.year {
            if startDate.month == endDate.month {
                if startDate.day == endDate.day {
                    return endDateFormatter.stringFromDate(endDate)
                } else {
                    startDateFormatter.dateFormat = "dd"
                }
            } else {
                startDateFormatter.dateFormat = "dd MMMM"
            }
        } else {
            startDateFormatter.dateFormat = "dd MMMM yyyy"
        }
        
        return startDateFormatter.stringFromDate(startDate) + " - " + endDateFormatter.stringFromDate(endDate)
    }
}
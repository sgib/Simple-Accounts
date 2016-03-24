//
//  TransactionDate.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 23/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

typealias TransactionDate = NSDate

enum DateComparisonResult: Int {
    case Earlier = -1
    case Same = 0
    case Later = 1
    
    var isEarlier: Bool {
        return self == .Earlier
    }
    
    var isSame: Bool {
        return self == .Same
    }
    
    var isLater: Bool {
        return self == .Later
    }
}

enum DateGranularity {
    case Week
    case Month
    case Year
    
    func convertToCalendarUnit() -> NSCalendarUnit {
        switch self {
        case .Week:
            return .WeekOfYear
        case .Month:
            return .Month
        case .Year:
            return .Year
        }
    }
}

extension TransactionDate {
    
    func compareTo(date: TransactionDate, toNearest: DateGranularity) -> DateComparisonResult {
        switch NSCalendar.currentCalendar().compareDate(self, toDate: date, toUnitGranularity: toNearest.convertToCalendarUnit()) {
        case .OrderedAscending:
            return .Earlier
        case .OrderedSame:
            return .Same
        case .OrderedDescending:
            return .Later
        }
    }

}
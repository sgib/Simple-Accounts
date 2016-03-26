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
    private var components: NSDateComponents {
        return NSCalendar.currentCalendar().components([.Day, .Month, .Year], fromDate: self)
    }
    
    private func dateFromComponents(components: NSDateComponents) -> NSDate {
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
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
    
    func dateAtTheStartOfMonth() -> NSDate {
        let components = self.components
        components.day = 1
        return dateFromComponents(components)
    }
    
    func dateAtTheEndOfMonth() -> NSDate {
        let components = self.components
        components.day = NSCalendar.currentCalendar().rangeOfUnit(.Day, inUnit: .Month, forDate: self).length
        return dateFromComponents(components)
    }

}
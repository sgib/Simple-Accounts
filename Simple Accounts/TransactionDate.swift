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

enum DateRangeSize {
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

enum Weekday: Int {
    case Sunday = 1
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
}

extension TransactionDate {
    private var components: NSDateComponents {
        return NSCalendar.currentCalendar().components([.Day, .Month, .Year], fromDate: self)
    }
    
    private func dateFromComponents(components: NSDateComponents) -> NSDate {
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    static var Today: TransactionDate {
        let todayComponents = TransactionDate().components
        return NSCalendar.currentCalendar().dateFromComponents(todayComponents)!
    }
    
    static func dateFrom(day day: Int, month: Int, year: Int) -> TransactionDate? {
        let components = NSDateComponents()
        components.day = day
        components.month = month
        components.year = year
        return NSCalendar.currentCalendar().dateFromComponents(components)
    }
    
    func compareTo(date: TransactionDate, toNearest: DateRangeSize) -> DateComparisonResult {
        switch NSCalendar.currentCalendar().compareDate(self, toDate: date, toUnitGranularity: toNearest.convertToCalendarUnit()) {
        case .OrderedAscending:
            return .Earlier
        case .OrderedSame:
            return .Same
        case .OrderedDescending:
            return .Later
        }
    }
    
    func dateByAddingDays(days: Int) -> TransactionDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: days, toDate: self, options: .MatchStrictly)!
    }
    
    func dateAtStartOfWeek(weekStartsOn: Weekday) -> TransactionDate {
        let previousWeekModifier = (self.weekday < weekStartsOn.rawValue) ? 7 : 0
        let dayDifference = weekStartsOn.rawValue - (self.weekday + previousWeekModifier)
        return self.dateByAddingDays(dayDifference)
    }
    
    func dateAtEndOfWeek(weekStartsOn: Weekday) -> TransactionDate {
        return self.dateAtStartOfWeek(weekStartsOn).dateByAddingDays(6)
    }
    
    func dateAtStartOfMonth() -> TransactionDate {
        let components = self.components
        components.day = 1
        return dateFromComponents(components)
    }
    
    func dateAtEndOfMonth() -> TransactionDate {
        let components = self.components
        components.day = NSCalendar.currentCalendar().rangeOfUnit(.Day, inUnit: .Month, forDate: self).length
        return dateFromComponents(components)
    }
    
    func dateAtStartOfYear() -> TransactionDate {
        let components = self.components
        components.day = 1
        components.month = 1
        return dateFromComponents(components)
    }

    func dateAtEndOfYear() -> TransactionDate {
        let components = self.components
        components.day = 31
        components.month = 12
        return dateFromComponents(components)
    }
    
    var day: Int {
        return NSCalendar.currentCalendar().component(.Day, fromDate: self)
    }
    
    var month: Int {
        return NSCalendar.currentCalendar().component(.Month, fromDate: self)
    }
    
    var year: Int {
        return NSCalendar.currentCalendar().component(.Year, fromDate: self)
    }
    
    var weekday: Int {
        return NSCalendar.currentCalendar().component(.Weekday, fromDate: self)
    }
}








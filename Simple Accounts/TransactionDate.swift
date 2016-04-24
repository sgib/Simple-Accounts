//
//  TransactionDate.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 23/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

typealias TransactionDate = NSDate

protocol DateRange {
    var startDate: TransactionDate { get }
    var endDate: TransactionDate { get }
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

struct TransactionCalendar {
    static let sharedCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
}

extension NSCalendar {
    func changeFirstWeekdayTo(weekday: Weekday) {
        self.firstWeekday = weekday.rawValue
    }
}

extension TransactionDate {
    private var components: NSDateComponents {
        return TransactionCalendar.sharedCalendar.components([.Day, .Month, .Year], fromDate: self)
    }
    
    private func dateFromComponents(components: NSDateComponents) -> TransactionDate {
        return TransactionCalendar.sharedCalendar.dateFromComponents(components)!
    }
    
    static var Today: TransactionDate {
        let todayComponents = TransactionDate().components
        return TransactionCalendar.sharedCalendar.dateFromComponents(todayComponents)!
    }
    
    static func dateFrom(day day: Int, month: Int, year: Int) -> TransactionDate? {
        let components = NSDateComponents()
        components.day = day
        components.month = month
        components.year = year
        return TransactionCalendar.sharedCalendar.dateFromComponents(components)
    }
    
    func dateWithZeroTime() -> TransactionDate {
        return dateFromComponents(self.components)
    }
    
    func dateByAddingDays(days: Int) -> TransactionDate {
        return TransactionCalendar.sharedCalendar.dateByAddingUnit(.Day, value: days, toDate: self, options: .MatchStrictly)!
    }
    
    func dateAtStartOfWeek() -> TransactionDate {
        let previousWeekModifier = (self.weekday < TransactionCalendar.sharedCalendar.firstWeekday) ? 7 : 0
        let dayDifference = TransactionCalendar.sharedCalendar.firstWeekday - (self.weekday + previousWeekModifier)
        return self.dateWithZeroTime().dateByAddingDays(dayDifference)
    }
    
    func dateAtEndOfWeek() -> TransactionDate {
        return self.dateAtStartOfWeek().dateByAddingDays(6)
    }
    
    func dateAtStartOfMonth() -> TransactionDate {
        let components = self.components
        components.day = 1
        return dateFromComponents(components)
    }
    
    func dateAtEndOfMonth() -> TransactionDate {
        let components = self.components
        components.day = TransactionCalendar.sharedCalendar.rangeOfUnit(.Day, inUnit: .Month, forDate: self).length
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
        return TransactionCalendar.sharedCalendar.component(.Day, fromDate: self)
    }
    
    var month: Int {
        return TransactionCalendar.sharedCalendar.component(.Month, fromDate: self)
    }
    
    var year: Int {
        return TransactionCalendar.sharedCalendar.component(.Year, fromDate: self)
    }
    
    var weekday: Int {
        return TransactionCalendar.sharedCalendar.component(.Weekday, fromDate: self)
    }
}

func <=(left: TransactionDate, right: TransactionDate) -> Bool {
    return left < right || left == right
}

func >=(left: TransactionDate, right: TransactionDate) -> Bool {
    return left > right || left == right
}

func <(left: TransactionDate, right: TransactionDate) -> Bool {
    return left.compare(right) == .OrderedAscending
}

func >(left: TransactionDate, right: TransactionDate) -> Bool {
    return left.compare(right) == .OrderedDescending
}





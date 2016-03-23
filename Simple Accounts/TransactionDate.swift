//
//  TransactionDate.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 23/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

typealias TransactionDate = NSDate

enum DateComparison: Int {
    case IsEarlier = -1
    case IsSame = 0
    case IsLater = 1
    
    var isEarlier: Bool {
        return self == .IsEarlier
    }
    
    var isSame: Bool {
        return self == .IsSame
    }
    
    var isLater: Bool {
        return self == .IsLater
    }
}

extension TransactionDate {
    
    func compareWithMonthGranularity(date: TransactionDate) -> DateComparison {
        switch NSCalendar.currentCalendar().compareDate(self, toDate: date, toUnitGranularity: .Month) {
        case .OrderedAscending:
            return .IsEarlier
        case .OrderedSame:
            return .IsSame
        case .OrderedDescending:
            return .IsLater
        }
    }

}
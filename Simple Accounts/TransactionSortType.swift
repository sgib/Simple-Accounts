//
//  TransactionSortType.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 28/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

typealias TransactionSortFunction = (Transaction, Transaction) -> Bool

enum TransactionSortType: String {
    case AmountHighToLow = "Amount (High - Low)"
    case AmountLowToHigh = "Amount (Low - High)"
    case CategoryAToZ = "Category (A - Z)"
    case CategoryZToA = "Category (Z - A)"
    case DateOldestFirst = "Date (Old - New)"
    case DateNewestFirst = "Date (New - Old)"
    
    var description: String {
        return rawValue
    }
    
    var sortFunction: TransactionSortFunction {
        switch self {
        case .AmountHighToLow:
            return { $0.amount > $1.amount }
        case .AmountLowToHigh:
            return { $0.amount < $1.amount }
        case .CategoryAToZ:
            return { $0.category.name < $1.category.name }
        case .CategoryZToA:
            return { $0.category.name > $1.category.name }
        case .DateOldestFirst:
            return { $0.date < $1.date }
        case .DateNewestFirst:
            return { $0.date > $1.date }
        }
    }
    
    static let allCases: [TransactionSortType] = [.AmountHighToLow, .AmountLowToHigh, .CategoryAToZ, .CategoryZToA, .DateOldestFirst, .DateNewestFirst]
}
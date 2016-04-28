//
//  TransactionSortType.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 28/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

typealias TransactionSortFunction = (Transaction, Transaction) -> Bool

enum TransactionSortType {
    case AmountHighToLow
    case AmountLowToHigh
    case CategoryAToZ
    case CategoryZToA
    case DateOldestFirst
    case DateNewestFirst
    
    var description: String {
        switch self {
        case .AmountHighToLow:
            return "Amount (High - Low)"
        case .AmountLowToHigh:
            return "Amount (Low - High)"
        case .CategoryAToZ:
            return "Category (A - Z)"
        case .CategoryZToA:
            return "Category (Z - A)"
        case .DateOldestFirst:
            return "Date (Old - New)"
        case .DateNewestFirst:
            return "Date (New - Old)"
        }
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
    
    static var allCases: [TransactionSortType] = [.AmountHighToLow, .AmountLowToHigh, .CategoryAToZ, .CategoryZToA, .DateOldestFirst, .DateNewestFirst]
}
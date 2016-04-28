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
    case amountHighToLow
    case amountLowToHigh
    case categoryAToZ
    case categoryZToA
    case dateOldestFirst
    case dateNewestFirst
    
    var description: String {
        switch self {
        case .amountHighToLow:
            return "Amount (High - Low)"
        case .amountLowToHigh:
            return "Amount (Low - High)"
        case .categoryAToZ:
            return "Category (A - Z)"
        case .categoryZToA:
            return "Category (Z - A)"
        case .dateOldestFirst:
            return "Date (Old - New)"
        case .dateNewestFirst:
            return "Date (New - Old)"
        }
    }
    
    var sortFunction: TransactionSortFunction {
        switch self {
        case .amountHighToLow:
            return { $0.amount > $1.amount }
        case .amountLowToHigh:
            return { $0.amount < $1.amount }
        case .categoryAToZ:
            return { $0.category.name < $1.category.name }
        case .categoryZToA:
            return { $0.category.name > $1.category.name }
        case .dateOldestFirst:
            return { $0.date < $1.date }
        case .dateNewestFirst:
            return { $0.date > $1.date }
        }
    }
    
    static var allCases: [TransactionSortType] = [.amountHighToLow, .amountLowToHigh, .categoryAToZ, .categoryZToA, .dateOldestFirst, .dateNewestFirst]
}
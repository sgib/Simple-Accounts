//
//  TransactionType.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 20/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

@objc enum TransactionType: Int16 {
    case Expense = -1
    case Income = 1
    
    var sign: Int16 {
        return rawValue
    }
}
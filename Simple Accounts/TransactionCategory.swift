//
//  TransactionCategory.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 20/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation


class TransactionCategory {
    var name: String
    var iconIndex: Int
    
    init(name: String, iconIndex: Int) {
        self.name = name
        self.iconIndex = iconIndex
    }
}
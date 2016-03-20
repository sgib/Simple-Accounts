//
//  TransactionCategory.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 20/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation


class TransactionCategory {
    typealias IconIndex = Int
    
    var name: String
    var icon: IconIndex
    
    init(name: String, icon: IconIndex) {
        self.name = name
        self.icon = icon
    }
}
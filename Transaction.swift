//
//  Transaction.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 25/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation
import CoreData


class Transaction: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    var signedAmount: Money {
        return amount * Money(integer: type.rawValue)
    }

}

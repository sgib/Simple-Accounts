//
//  Transaction+CoreDataProperties.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 25/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

typealias TransactionID = NSUUID

extension Transaction {

    @NSManaged var transactionID: TransactionID
    @NSManaged var amount: Money
    @NSManaged var transactionDescription: String?
    @NSManaged var date: TransactionDate
    @NSManaged var type: TransactionType
    @NSManaged var category: TransactionCategory

}

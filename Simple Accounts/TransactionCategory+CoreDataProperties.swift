//
//  TransactionCategory+CoreDataProperties.swift
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

extension TransactionCategory {
    
    @NSManaged var name: String
    @NSManaged var icon: String
    @NSManaged var transactions: Set<Transaction>

}

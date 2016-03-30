//
//  CoreDataTestHarness.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 25/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation
@testable import Simple_Accounts


class CoreDataTestHelper {
    static let sharedInstance = CoreDataTestHelper()
    
    private let dataSource: CoreDataStack
    let account: Account
    let categoryStore: CategoryStore
    
    private init() {
        self.dataSource = CoreDataStack(modelName: "AccountsModelTest", storeType: .Persistent)
        self.account = Account(openingBalance: Money.zero(), dataSource: self.dataSource)
        self.categoryStore = CategoryStore(dataSource: self.dataSource)
    }
    
    func resetData() {
        dataSource.deleteEntity(Transaction.self, matchingPredicate: nil)
        dataSource.deleteEntity(TransactionCategory.self, matchingPredicate: nil)
        dataSource.reset()
    }
}
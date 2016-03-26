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
    private let dataSource: CoreDataStack
    let account: Account
    let categoryStore: CategoryStore
    
    init(accountOpeningBalance: Money) {
        self.dataSource = CoreDataStack(modelName: "AccountsModel", storeType: .InMemory)
        self.account = Account(openingBalance: accountOpeningBalance, dataSource: self.dataSource)
        self.categoryStore = CategoryStore(dataSource: self.dataSource)
    }
    
    func resetData() {
        dataSource.reset()
    }
}
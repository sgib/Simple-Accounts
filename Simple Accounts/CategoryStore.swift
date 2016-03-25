//
//  CategoryStore.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 25/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

class CategoryStore {
    private let dataSource: CoreDataStack
    
    init(dataSource: CoreDataStack) {
        self.dataSource = dataSource
    }
    
    func addCategory(categoryData: TransactionCategoryData) -> TransactionCategory {
        let predicate = NSPredicate(format: "name == '\(categoryData.name)'")
        let category = dataSource.getManagedEntity(TransactionCategory.self, matchingPredicate: predicate, withStateSettingFunction: { newCategory in
            newCategory.name = categoryData.name
            newCategory.icon = categoryData.icon
        })
        return category
    }
}
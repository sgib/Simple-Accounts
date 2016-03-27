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
        if let category = dataSource.getSingleEntity(TransactionCategory.self, matchingPredicate: predicate) {
            return category
        } else {
            let category = dataSource.createManagedEntity(TransactionCategory.self)
            category.name = categoryData.name
            category.icon = categoryData.icon
            return category
        }
    }
}
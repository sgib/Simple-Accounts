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
    
    ///adds a category to the store and returns it, or returns nil if category already exists or is invalid.
    func addCategory(categoryData: TransactionCategoryData) -> TransactionCategory? {
        let trimmedName = categoryData.name.trim()
        guard trimmedName.isNotEmpty else {
            return nil
        }
        
        let predicate = NSPredicate(format: "name ==[c] %@", trimmedName)
        if dataSource.getSingleEntity(TransactionCategory.self, matchingPredicate: predicate) != nil {
            return nil
        } else {
            let category = dataSource.createManagedEntity(TransactionCategory.self)
            category.name = trimmedName
            category.icon = categoryData.icon
            return category
        }
    }
}

extension String {
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
}
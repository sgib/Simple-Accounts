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
    private let categoryNameSort = [NSSortDescriptor(key: "name", ascending: true)]
    
    init(dataSource: CoreDataStack) {
        self.dataSource = dataSource
    }
    
    ///adds a category to the store and returns it, or returns nil if category already exists or is invalid.
    func addCategory(categoryData: TransactionCategoryData) -> TransactionCategory? {
        let trimmedName = categoryData.name.trim()
        guard trimmedName.isNotEmpty else {
            return nil
        }
        
        if dataSource.getSingleEntity(TransactionCategory.self, matchingPredicate: predicateForName(trimmedName)) != nil {
            return nil
        } else {
            let category = dataSource.createManagedEntity(TransactionCategory.self)
            category.name = trimmedName
            category.icon = categoryData.icon
            dataSource.saveChanges()
            return category
        }
    }
    
    ///attempts to save the changes to the given category, returns true if sucessful, otherwise returns false and rolls-back any changes.
    func updateCategory(category: TransactionCategory) -> Bool {
        category.name = category.name.trim()
        let matchingNames = dataSource.fetchEntity(TransactionCategory.self, matchingPredicate: predicateForName(category.name), sortedBy: nil).simpleResult()
        
        if category.name.isNotEmpty && matchingNames.count == 1 {
            dataSource.saveChanges()
            return true
        } else {
            dataSource.rollback()
            return false
        }
    }
    
    ///attempts to delete the given category, returns true if sucessful, otherwise returns false.
    func deleteCategory(category: TransactionCategory) -> Bool {
        if category.transactions.isEmpty {
            return dataSource.deleteEntity(TransactionCategory.self, matchingPredicate: predicateForName(category.name)) == nil
        } else {
            return false
        }
    }
    
    func allCategories() -> [TransactionCategory] {
        return dataSource.fetchEntity(TransactionCategory.self, matchingPredicate: nil, sortedBy: categoryNameSort).simpleResult()
    }
    
    private func predicateForName(name: String) -> NSPredicate {
        return NSPredicate(format: "name ==[c] %@", name)
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
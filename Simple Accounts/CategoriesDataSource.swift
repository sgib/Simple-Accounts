//
//  CategoriesDataSource.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 14/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class CategoriesDataSource: NSObject, UITableViewDataSource {
    
    private let defaultReuseID = "DefaultCategoryCell"
    private let emptyReuseID = "EmptyCategoryCell"
    private let addCellReuseID = "AddCategoryCell"
    
    enum DataSection: Int {
        case categoryListSection = 0
        case emptyListMessageSection = 1
        case addCategorySection = 2
        
        var sectionIndex: Int {
            return rawValue
        }
    }
    
    var showsAddCategoryRow: Bool = false
    
    //MARK: - Dependencies
    
    var categoryStore: CategoryStore!
    
    //MARK: - Table Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (showsAddCategoryRow) ? 3 : 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categoryCount = categoryStore.allCategories().count
        if section == DataSection.categoryListSection.sectionIndex {
            return categoryCount
        } else if section == DataSection.emptyListMessageSection.sectionIndex {
            return (categoryCount == 0) ? 1 : 0
        } else {
            return (showsAddCategoryRow) ? 1 : 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == DataSection.categoryListSection.sectionIndex {
            let cell = tableView.dequeueReusableCellWithIdentifier(defaultReuseID, forIndexPath: indexPath)
            let category = categoryStore.allCategories()[indexPath.row]
            cell.textLabel?.text = category.name
            cell.imageView?.image = UIImage(named: category.icon)
            return cell
        } else if indexPath.section == DataSection.emptyListMessageSection.sectionIndex {
            return tableView.dequeueReusableCellWithIdentifier(emptyReuseID, forIndexPath: indexPath)
        } else {
            return tableView.dequeueReusableCellWithIdentifier(addCellReuseID, forIndexPath: indexPath)
        }
    }
    
    //MARK: - Categories Setup
    ///creates and adds 'default' categories to the CategoryStore
    func createDefaultCategories() {
        categoryStore.addCategory(TransactionCategoryData(name: "Salary", icon: "BanknotesIcon.png"))
        categoryStore.addCategory(TransactionCategoryData(name: "Books", icon: "BookIcon.png"))
        categoryStore.addCategory(TransactionCategoryData(name: "Clothes", icon: "ClothingIcon.png"))
        categoryStore.addCategory(TransactionCategoryData(name: "Gifts", icon: "GiftIcon.png"))
        categoryStore.addCategory(TransactionCategoryData(name: "Food", icon: "RestaurantIcon.png"))
        categoryStore.addCategory(TransactionCategoryData(name: "Shopping", icon: "ShoppingCartIcon.png"))
        categoryStore.addCategory(TransactionCategoryData(name: "Fuel", icon: "PetrolIcon.png"))
        categoryStore.addCategory(TransactionCategoryData(name: "Holidays", icon: "AirportIcon.png"))
    }
}

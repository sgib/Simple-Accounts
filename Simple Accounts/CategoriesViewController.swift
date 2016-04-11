//
//  SecondViewController.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 19/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var imageResources = ImageResourceLoader.sharedInstance
    private let defaultReuseID = "DefaultCategoryCell"
    private let emptyReuseID = "EmptyCategoryCell"
    
    //MARK: - Dependencies
    
    var categoryStore: CategoryStore!
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!

    //MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destVC = segue.destinationViewController as? AddCategoryViewController {
            destVC.categoryStore = categoryStore
            destVC.mode = .Add
            if !(sender is UIBarButtonItem) {
                let category = categoryStore.allCategories()[tableView.indexPathForSelectedRow!.row]
                destVC.mode = .Edit(category)
                tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: true)
            }
        }
    }
    
    @IBAction func unwindFromAdd(segue: UIStoryboardSegue) {
        tableView.reloadData()
        adjustTableHeight()
    }
    
    //MARK: - Private functions
    
    private func adjustTableHeight() {
        tableHeightConstraint.constant = tableView.contentSize.height
    }
    
    //MARK: - Table View functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categoryCount = categoryStore.allCategories().count
        if section == 0 {
            return categoryCount
        } else {
            return (categoryCount == 0) ? 1 : 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(defaultReuseID, forIndexPath: indexPath)
            let category = categoryStore.allCategories()[indexPath.row]
            cell.textLabel?.text = category.name
            cell.imageView?.image = UIImage(named: category.icon)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(emptyReuseID, forIndexPath: indexPath)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            categoryStore.addCategory(TransactionCategoryData(name: "Salary", icon: "BanknotesIcon.png"))
            categoryStore.addCategory(TransactionCategoryData(name: "Books", icon: "BookIcon.png"))
            categoryStore.addCategory(TransactionCategoryData(name: "Clothes", icon: "ClothingIcon.png"))
            categoryStore.addCategory(TransactionCategoryData(name: "Gifts", icon: "GiftIcon.png"))
            categoryStore.addCategory(TransactionCategoryData(name: "Food", icon: "RestaurantIcon.png"))
            categoryStore.addCategory(TransactionCategoryData(name: "Shopping", icon: "ShoppingCartIcon.png"))
            categoryStore.addCategory(TransactionCategoryData(name: "Fuel", icon: "PetrolIcon.png"))
            categoryStore.addCategory(TransactionCategoryData(name: "Holidays", icon: "AirportIcon.png"))
            tableView.reloadData()
            adjustTableHeight()
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidLayoutSubviews() {
        adjustTableHeight()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


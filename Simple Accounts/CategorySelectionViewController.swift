//
//  CategorySelectionViewController.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 10/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class CategorySelectionViewController: UIViewController, UITableViewDelegate, AddEditCategoryDelegate {

    private let unwindSegueID = "unwindFromCategorySelect"
    private let tableDataSource = CategoriesDataSource()
    var chosenCategory: TransactionCategory?
    
    //MARK: - Dependencies
    
    var categoryStore: CategoryStore!
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    //MARK: - Actions
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        performSegueWithIdentifier(unwindSegueID, sender: self)
    }
    
    //MARK: - Table delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == CategoriesDataSource.DataSection.categoryListSection.rawValue {
            chosenCategory = categoryStore.allCategories()[indexPath.row]
            doneButton.enabled = true
        } else if indexPath.section == CategoriesDataSource.DataSection.emptyListMessageSection.rawValue {
            tableDataSource.createDefaultCategories()
            tableView.reloadData()
        }
    }
    
    //MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destVC = segue.destinationViewController as? AddCategoryViewController {
            destVC.navigationItem.leftBarButtonItems?.removeAll()
            destVC.mode = .Add
            destVC.categoryStore = categoryStore
            destVC.delegate = self
        }
    }
    
    func addCategoryController(controller: AddCategoryViewController, didAddEdit: AddEditResult<TransactionCategory>) {
        if case let .DidAdd(category) = didAddEdit {
            chosenCategory = category
            navigationController?.popViewControllerAnimated(true)
            performSegueWithIdentifier(unwindSegueID, sender: self)
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableDataSource.categoryStore = self.categoryStore
        tableDataSource.showsAddCategoryRow = true
        tableView.dataSource = tableDataSource
    }
    
    override func viewDidAppear(animated: Bool) {
        if let category = chosenCategory {
            let categoryIndex = categoryStore.allCategories().indexOf(category)!
            tableView.selectRowAtIndexPath(NSIndexPath(forRow: categoryIndex, inSection: 0), animated: false, scrollPosition: .None)
            doneButton.enabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

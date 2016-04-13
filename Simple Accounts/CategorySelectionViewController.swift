//
//  CategorySelectionViewController.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 10/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class CategorySelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddEditCategoryDelegate {

    private let unwindSegueID = "unwindFromCategorySelect"
    private let defaultCellReuseID = "DefaultCategoryCell"
    private let addCellReuseID = "AddCategoryCell"
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
    
    //MARK: - Table data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return categoryStore.allCategories().count
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(defaultCellReuseID, forIndexPath: indexPath)
            let category = categoryStore.allCategories()[indexPath.row]
            cell.textLabel?.text = category.name
            cell.imageView?.image = UIImage(named: category.icon)
            return cell
        } else {
            return tableView.dequeueReusableCellWithIdentifier(addCellReuseID, forIndexPath: indexPath)
        }
    }
    
    //MARK: - Table delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            chosenCategory = categoryStore.allCategories()[indexPath.row]
            doneButton.enabled = true
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

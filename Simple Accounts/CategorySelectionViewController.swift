//
//  CategorySelectionViewController.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 10/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class CategorySelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let unwindSegueID = "unwindFromCategorySelect"
    var chosenCategory: TransactionCategory?
    
    //MARK: - Dependencies
    
    var categoryStore: CategoryStore!
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    //MARK: - Actions
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        performSegueWithIdentifier(unwindSegueID, sender: self)
    }
    
    //MARK: - Table data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryStore.allCategories().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DefaultCategoryCell", forIndexPath: indexPath)
        let category = categoryStore.allCategories()[indexPath.row]
        cell.textLabel?.text = category.name
        cell.imageView?.image = UIImage(named: category.icon)
        return cell
    }
    
    //MARK: - Table delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        chosenCategory = categoryStore.allCategories()[indexPath.row]
        doneButton.enabled = true
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let category = chosenCategory {
            let categoryIndex = categoryStore.allCategories().indexOf(category)!
            tableView.selectRowAtIndexPath(NSIndexPath(forItem: categoryIndex, inSection: 0), animated: false, scrollPosition: .None)
            doneButton.enabled = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        tableHeightConstraint.constant = tableView.contentSize.height
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

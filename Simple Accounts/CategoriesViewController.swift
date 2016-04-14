//
//  SecondViewController.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 19/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, AddEditCategoryDelegate {

    private var imageResources = ImageResourceLoader.sharedInstance
    private let tableDataSource = CategoriesDataSource()
    
    //MARK: - Dependencies
    
    var categoryStore: CategoryStore!
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!

    //MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destVC = segue.destinationViewController.childViewControllers.first as? AddCategoryViewController {
            destVC.delegate = self
            destVC.categoryStore = categoryStore
            destVC.mode = .Add
            if !(sender is UIBarButtonItem) {
                let category = categoryStore.allCategories()[tableView.indexPathForSelectedRow!.row]
                destVC.mode = .Edit(category)
                tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: true)
            }
        }
    }
    
    func addCategoryController(controller: AddCategoryViewController, didAddEdit: AddEditResult<TransactionCategory>) {
        dismissViewControllerAnimated(true, completion: nil)
        tableView.reloadData()
    }
    
    //MARK: - Table View functions
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == CategoriesDataSource.DataSection.emptyListMessageSection.rawValue {
            tableDataSource.createDefaultCategories()
            tableView.reloadData()
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableDataSource.categoryStore = self.categoryStore
        tableView.dataSource = tableDataSource
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //Categories may have been added in Transaction tab
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


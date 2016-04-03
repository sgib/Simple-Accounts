//
//  SecondViewController.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 19/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var categoryStore: CategoryStore!
    var imageResources = ImageResourceLoader.sharedInstance
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!

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
    
    private func adjustTableHeight() {
        tableHeightConstraint.constant = tableView.contentSize.height
    }
    
    //MARK: - Table View functions
    
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


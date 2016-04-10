//
//  AddTransactionViewController.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 09/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class AddTransactionViewController: UITableViewController {

    private var datePickerVisible = false
    private var chosenCategory: TransactionCategory?
    
    //MARK: - Dependencies
    var mode: AddEditMode<Transaction>!
    var account: Account!
    var categoryStore: CategoryStore!
    
    //MARK: - Outlets
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var typeSegmentControl: UISegmentedControl!
    @IBOutlet weak var dateDisplayLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var categoryDisplayLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    //MARK: - Navigation
    
    @IBAction func unwindFromCategorySelection(segue: UIStoryboardSegue) {
        if let categorySelection = segue.sourceViewController as? CategorySelectionViewController {
            if let category = categorySelection.chosenCategory {
                chosenCategory = category
                updateCategoryDisplay(category)
                if case let .Edit(transaction) = mode! {
                    transaction.category = category
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destVC = segue.destinationViewController as? CategorySelectionViewController {
            destVC.categoryStore = categoryStore
            destVC.chosenCategory = chosenCategory
            if case let .Edit(transaction) = mode! {
                destVC.chosenCategory = transaction.category
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
    }
    
    @IBAction func deleteButtonPressed(sender: UIButton) {
    }
    
    @IBAction func dateValueChanged() {
        updateDateDisplay(datePicker.date)
    }
    
    //MARK: - Table view functions
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return deleteButton.hidden ? 1 : 2
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 1 && indexPath.section == 0 {
            setDatePickerVisible(!datePickerVisible)
        } else {
            setDatePickerVisible(false)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if !datePickerVisible && indexPath.section == 0 && indexPath.row == 2 {
            return 0
        } else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    //MARK: - Private functions
    
    private func setDatePickerVisible(visible: Bool) {
        tableView.beginUpdates()
        datePickerVisible = visible
        tableView.endUpdates()
    }
    
    private func updateDateDisplay(date: TransactionDate) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        dateDisplayLabel.text = formatter.stringFromDate(date)
    }
    
    private func updateCategoryDisplay(category: TransactionCategory?) {
        categoryDisplayLabel.text = category?.name ?? "None"
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if case let .Edit(transaction) = mode! {
            navigationBar.title = "Edit Transaction"
            deleteButton.hidden = false
            typeSegmentControl.selectedSegmentIndex = (transaction.type == .Expense) ? 0 : 1
            updateDateDisplay(transaction.date)
            updateCategoryDisplay(transaction.category)
            amountTextField.text = "£ \(transaction.amount)"
            descriptionTextField.text = transaction.transactionDescription
        } else {
            dateValueChanged()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

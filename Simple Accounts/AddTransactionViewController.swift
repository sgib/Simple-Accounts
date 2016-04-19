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
    private let unwindSegueID = "unwindFromAddTransaction"
    private let dateDisplayIndexPath = NSIndexPath(forRow: 1, inSection: 0)
    private let datePickerIndexPath = NSIndexPath(forRow: 2, inSection: 0)
    private var chosenCategory: TransactionCategory?
    
    //MARK: - Dependencies
    var mode: AddEditMode<Transaction>!
    var account: Account!
    var categoryStore: CategoryStore!
    var formatter: AccountsFormatter!
    var defaultDateForNewTransactions = TransactionDate.Today
    
    //MARK: - Outlets
    
    @IBOutlet weak var typeSegmentControl: UISegmentedControl!
    @IBOutlet weak var dateDisplayLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var categoryDisplayLabel: UILabel!
    @IBOutlet weak var amountTextField: CurrencyTextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIButton!
    
    //MARK: - Actions
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        if let category = chosenCategory {
            let transType: TransactionType = (typeSegmentControl.selectedSegmentIndex == 0) ? .Expense : .Income
            let description: String? = (descriptionTextField.unwrappedText.isNotEmpty) ? descriptionTextField.unwrappedText : nil
            switch mode! {
            case .Add:
                let data = TransactionData(amount: amountTextField.enteredAmount,
                                           category: category,
                                           date: datePicker.date,
                                           description: description,
                                           type: transType)
                account.addTransaction(data)
            case .Edit(let transaction):
                transaction.amount = amountTextField.enteredAmount
                transaction.category = category
                transaction.date = datePicker.date
                transaction.transactionDescription = description
                transaction.type = transType
                account.updateTransaction(transaction)
            }
            performSegueWithIdentifier(unwindSegueID, sender: self)
        }
    }
    
    @IBAction func deleteButtonPressed(sender: UIButton) {
        if case let .Edit(transaction) = mode! {
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .ActionSheet)
            actionSheet.addAction(UIAlertAction(title: "Delete", style: .Destructive, handler: { _ in
                self.account.deleteTransaction(transaction)
                self.performSegueWithIdentifier(self.unwindSegueID, sender: self)
            }))
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
            presentViewController(actionSheet, animated: true, completion: nil)
        }
    }
    
    @IBAction func dateValueChanged() {
        dateDisplayLabel.text = formatter.dateStringFrom(datePicker.date)
    }
    
    @IBAction func amountEntryBegan(sender: UITextField) {
        setDatePickerVisible(false)
    }
    
    //MARK: - Navigation
    
    @IBAction func unwindFromCategorySelection(segue: UIStoryboardSegue) {
        if let categorySelection = segue.sourceViewController as? CategorySelectionViewController {
            if let category = categorySelection.chosenCategory {
                updateCategoryDisplay(category)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destVC = segue.destinationViewController as? CategorySelectionViewController {
            destVC.categoryStore = categoryStore
            destVC.chosenCategory = chosenCategory
        }
    }
    
    //MARK: - Table view functions
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return deleteButton.hidden ? 1 : 2
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath == dateDisplayIndexPath {
            setDatePickerVisible(!datePickerVisible)
        } else {
            setDatePickerVisible(false)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if !datePickerVisible && indexPath == datePickerIndexPath {
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
    
    private func updateCategoryDisplay(category: TransactionCategory) {
        chosenCategory = category
        saveButton.enabled = true
        categoryDisplayLabel.text = category.name
    }
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        amountTextField.formatter = formatter
        
        if case let .Edit(transaction) = mode! {
            self.title = "Edit Transaction"
            saveButton.enabled = true
            deleteButton.hidden = false
            typeSegmentControl.selectedSegmentIndex = (transaction.type == .Expense) ? 0 : 1
            datePicker.date = transaction.date
            updateCategoryDisplay(transaction.category)
            amountTextField.enteredAmount = transaction.amount
            descriptionTextField.text = transaction.transactionDescription
        } else {
            datePicker.date = defaultDateForNewTransactions
        }
        dateValueChanged()
    }
}

//MARK: Text field delegate
extension AddTransactionViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        setDatePickerVisible(false)
    }
}





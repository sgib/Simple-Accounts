//
//  AddTransactionViewController.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 09/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class AddTransactionViewController: UITableViewController, UITextFieldDelegate {

    private var datePickerVisible = false
    private var chosenCategory: TransactionCategory?
    private var enteredAmount = Money.zero()
    
    //MARK: - Dependencies
    var mode: AddEditMode<Transaction>!
    var account: Account!
    var categoryStore: CategoryStore!
    
    //MARK: - Outlets
    
    @IBOutlet weak var typeSegmentControl: UISegmentedControl!
    @IBOutlet weak var dateDisplayLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var categoryDisplayLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIButton!
    
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
    
    //MARK: - TextField functions
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == amountTextField {
            let combinedStrings = (textField.unwrappedText as NSString).stringByReplacingCharactersInRange(range, withString: string)
            guard combinedStrings.occurrencesOfSubstring(".") <= 1 else {
                return false
            }
            let newCharacters = NSCharacterSet(charactersInString: string)
            let allowedInput = NSCharacterSet(charactersInString: "0123456789.")
            return allowedInput.isSupersetOfSet(newCharacters)
        } else {
            return true
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        setDatePickerVisible(false)
    }
    
    @IBAction func amountEntryBegan(sender: UITextField) {
        amountTextField.text = (enteredAmount != Money.zero()) ? "\(enteredAmount)" : ""
    }
    
    @IBAction func amountEntryEnded(sender: UITextField) {
        let inputAmount = Money(string: amountTextField.unwrappedText)
        let amount = (inputAmount == Money.notANumber()) ? Money.zero() : inputAmount
        updateAmountDisplay(amount)
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
    
    private func updateCategoryDisplay(category: TransactionCategory) {
        chosenCategory = category
        saveButton.enabled = true
        categoryDisplayLabel.text = category.name
    }
    
    private func updateAmountDisplay(amount: Money) {
        enteredAmount = amount.moneyRoundedToTwoDecimalPlaces()
        amountTextField.text = NSNumberFormatter.localizedStringFromNumber(enteredAmount, numberStyle: .CurrencyStyle)
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        amountTextField.placeholder = NSNumberFormatter.localizedStringFromNumber(Money.zero(), numberStyle: .CurrencyStyle)
        if case let .Edit(transaction) = mode! {
            self.title = "Edit Transaction"
            saveButton.enabled = true
            deleteButton.hidden = false
            typeSegmentControl.selectedSegmentIndex = (transaction.type == .Expense) ? 0 : 1
            updateDateDisplay(transaction.date)
            updateCategoryDisplay(transaction.category)
            updateAmountDisplay(transaction.amount)
            descriptionTextField.text = transaction.transactionDescription
        } else {
            dateValueChanged()
            updateAmountDisplay(Money.zero())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

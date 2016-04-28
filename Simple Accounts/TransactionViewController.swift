//
//  FirstViewController.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 19/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {

    private let reuseID = "TransactionCell"
    private var currentRange: StandardTransactionDateRange!
    private var transactionsDataSource: TransactionsDataSource!
    
    //MARK: - Dependencies
    var account: Account!
    var categoryStore: CategoryStore!
    var formatter: AccountsFormatter!
    
    //MARK: - Outlets
    
    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var periodButton: UIButton!
    @IBOutlet weak var openingBalanceLabel: UILabel!
    @IBOutlet weak var totalIncomeLabel: UILabel!
    @IBOutlet weak var totalExpensesLabel: UILabel!
    @IBOutlet weak var aggregateLabel: UILabel!
    @IBOutlet weak var closingBalanceLabel: UILabel!
    @IBOutlet weak var rangeDisplayButton: BorderedButton!
    
    //MARK: - Actions
    
    @IBAction func previousButtonPressed(sender: UIButton) {
        currentRange = currentRange.previous()
        updateRangeDisplay()
    }
    
    @IBAction func nextButtonPressed(sender: UIButton) {
        currentRange = currentRange.next()
        updateRangeDisplay()
    }
    
    @IBAction func rangeButtonPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil) //remove any other popovers
        let actionSheet = UIAlertController(title: "Change date range", message: nil, preferredStyle: .ActionSheet)
        for size in StandardTransactionDateRange.Size.allCases {
            actionSheet.addAction(createRangeChangingActionWithTitle(size.description, rangeSize: size))
        }
        actionSheet.popoverPresentationController?.sourceRect = sender.bounds
        actionSheet.popoverPresentationController?.sourceView = sender
        presentViewController(actionSheet, animated: true, completion: nil)
    }

    //MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        dismissViewControllerAnimated(true, completion: nil) //remove any other popovers
        if let destVC = segue.destinationViewController.childViewControllers.first as? AddTransactionViewController {
            destVC.account = account
            destVC.categoryStore = categoryStore
            destVC.formatter = formatter
            destVC.mode = .Add
            destVC.defaultDateForNewTransactions = (currentRange.contains(TransactionDate.Today)) ? TransactionDate.Today : currentRange.startDate
            if !(sender is UIBarButtonItem) {
                let transaction = transactionsDataSource.currentTransactions[transactionTableView.indexPathForSelectedRow!.row]
                destVC.mode = .Edit(transaction)
                transactionTableView.deselectRowAtIndexPath(transactionTableView.indexPathForSelectedRow!, animated: true)
            }
        } else if let destVC = segue.destinationViewController as? SortPickerViewController {
            destVC.sortType = transactionsDataSource.sortType
            destVC.delegate = self
        }
    }
    
    @IBAction func unwindFromAddTransaction(segue: UIStoryboardSegue) {
        loadTransactionData()
    }
    
    //MARK: - Private functions
    
    private func loadRange() {
        //TODO: if can load from UserDefaults, else...
        currentRange = StandardTransactionDateRange.rangeFromDate(TransactionDate.Today, withSize: .Month)
        updateRangeDisplay()
    }
    
    private func updateRangeDisplay() {
        rangeDisplayButton.setTitle(currentRange.displayName, forState: .Normal)
        loadTransactionData()
    }
    
    private func changeRangeSizeTo(size: StandardTransactionDateRange.Size) {
        if currentRange.size != size {
            currentRange = StandardTransactionDateRange.rangeFromDate(TransactionDate.Today, withSize: size)
            updateRangeDisplay()
        }
    }
    
    private func loadTransactionData() {
        transactionsDataSource.loadDataForRange(currentRange)
        transactionTableView.reloadData()
        updateBalanceDisplays()
    }
    
    private func createRangeChangingActionWithTitle(title: String, rangeSize: StandardTransactionDateRange.Size) -> UIAlertAction {
        return  UIAlertAction(title: title, style: .Default, handler: { _ in
            self.changeRangeSizeTo(rangeSize)
        })
    }
    
    private func updateBalanceDisplays() {
        let openingBalance = account.balanceAtStartOfDate(currentRange.startDate)
        openingBalanceLabel.text = "Opening: \(formatter.currencyStringFrom(openingBalance))"
        totalIncomeLabel.text = formatter.currencyStringFrom(transactionsDataSource.currentTransactions.sumIncome)
        aggregateLabel.text = "Net: \(formatter.currencyStringFrom(transactionsDataSource.currentTransactions.sumAggregate))"
        totalExpensesLabel.text = formatter.currencyStringFrom(transactionsDataSource.currentTransactions.sumExpenses)
        closingBalanceLabel.text = "Closing: \(formatter.currencyStringFrom(openingBalance + transactionsDataSource.currentTransactions.sumAggregate))"
    }
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transactionsDataSource = TransactionsDataSource(account: account, formatter: formatter, sortType: .DateOldestFirst)
        transactionTableView.dataSource = transactionsDataSource
        
        loadRange()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //Categories may have been edited on Category tab
        transactionTableView.reloadData()
    }
}

extension TransactionViewController: TransactionSortPickerDelegate {
    func sortPicker(sortPicker: SortPickerViewController, didChangeSortTo sortType: TransactionSortType) {
        transactionsDataSource.sortType = sortType
        transactionTableView.reloadData()
    }
}










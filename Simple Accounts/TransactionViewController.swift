//
//  FirstViewController.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 19/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let reuseID = "TransactionCell"
    private var currentRange: TransactionDateRange!
    private var currentTransactions = TransactionCollection()
    
    //MARK: - Dependencies
    var account: Account!
    var categoryStore: CategoryStore!
    
    //MARK: - Outlets
    
    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var periodButton: UIButton!
    @IBOutlet weak var openingBalanceLabel: UILabel!
    @IBOutlet weak var totalIncomeLabel: UILabel!
    @IBOutlet weak var totalExpensesLabel: UILabel!
    @IBOutlet weak var aggregateLabel: UILabel!
    @IBOutlet weak var closingBalanceLabel: UILabel!
    @IBOutlet weak var rangeDisplayButton: BorderedButton!
    
    //MARK: - Private functions
    
    private func loadRange() {
        //TODO: if can load from UserDefaults, else...
        currentRange = TransactionDateRange.rangeFromDate(TransactionDate.Today, withSize: .Month)
        updateRangeDisplay()
    }
    
    private func updateRangeDisplay() {
        rangeDisplayButton.setTitle(currentRange.displayName, forState: .Normal)
        loadTransactionData()
    }
    
    private func changeRangeLengthTo(size: DateRangeSize) {
        if currentRange.size != size {
            currentRange = TransactionDateRange.rangeFromDate(TransactionDate.Today, withSize: size)
            updateRangeDisplay()
        }
    }
    
    private func loadTransactionData() {
        currentTransactions = account.transactionsForRange(currentRange)
        transactionTableView.reloadData()
        updateBalanceDisplays()
    }
    
    private func updateBalanceDisplays() {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        let openingBalance = account.balanceAtStartOfRange(currentRange)
        openingBalanceLabel.text = "Opening: \(formatter.stringFromNumber(openingBalance)!)"
        totalIncomeLabel.text = formatter.stringFromNumber(currentTransactions.sumIncome)!
        aggregateLabel.text = "Net: \(formatter.stringFromNumber(currentTransactions.sumAggregate)!)"
        totalExpensesLabel.text = formatter.stringFromNumber(currentTransactions.sumExpenses)!
        closingBalanceLabel.text = "Closing: \(formatter.stringFromNumber(openingBalance + currentTransactions.sumAggregate)!)"
    }
    
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
        let actionSheet = UIAlertController(title: "Change date range", message: nil, preferredStyle: .ActionSheet)
        actionSheet.addAction(UIAlertAction(title: "Week", style: .Default, handler: {_ in self.changeRangeLengthTo(.Week) }))
        actionSheet.addAction(UIAlertAction(title: "Month", style: .Default, handler: {_ in self.changeRangeLengthTo(.Month) }))
        actionSheet.addAction(UIAlertAction(title: "Year", style: .Default, handler: {_ in self.changeRangeLengthTo(.Year) }))
        actionSheet.popoverPresentationController?.sourceRect = sender.bounds
        actionSheet.popoverPresentationController?.sourceView = sender
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    //MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destVC = segue.destinationViewController.childViewControllers.first as? AddTransactionViewController {
            destVC.account = account
            destVC.categoryStore = categoryStore
            destVC.mode = .Add
            destVC.defaultDateForNewTransactions = (currentRange.contains(TransactionDate.Today)) ? TransactionDate.Today : currentRange.startDate
            if !(sender is UIBarButtonItem) {
                let transaction = currentTransactions[transactionTableView.indexPathForSelectedRow!.row]
                destVC.mode = .Edit(transaction)
                transactionTableView.deselectRowAtIndexPath(transactionTableView.indexPathForSelectedRow!, animated: true)
            }
        }
    }
    
    @IBAction func unwindFromAddTransaction(segue: UIStoryboardSegue) {
        loadTransactionData()
    }
    
    //MARK: - Table view
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTransactions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseID, forIndexPath: indexPath) as! TransactionTableViewCell
        cell.transaction = currentTransactions[indexPath.row]
        return cell
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadRange()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //Categories may have been edited on Category tab
        transactionTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}












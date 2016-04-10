//
//  FirstViewController.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 19/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {

    private var currentRange: TransactionDateRange!
    
    //MARK: - Dependencies
    var account: Account!
    var categoryStore: CategoryStore!
    
    //MARK: - Outlets
    
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
        //TODO: load transactions for range from database
    }
    
    private func changeRangeLengthTo(size: DateRangeSize) {
        if currentRange.size != size {
            currentRange = TransactionDateRange.rangeFromDate(TransactionDate.Today, withSize: size)
            updateRangeDisplay()
        }
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
        if let destVC = segue.destinationViewController as? AddTransactionViewController {
            destVC.account = account
            destVC.categoryStore = categoryStore
            destVC.mode = .Add
            if !(sender is UIBarButtonItem) {
                //edit selected transaction
            }
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadRange()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}












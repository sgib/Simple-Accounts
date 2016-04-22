//
//  ReportOptionsTableViewController.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 20/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class ReportOptionsTableViewController: UITableViewController {

    private let showReportSegueID = "ShowReportSegue"
    private var startDatePickerVisible = false
    private var endDatePickerVisible = false
    private let startDateDisplayIndexPath = NSIndexPath(forRow: 0, inSection: 0)
    private let startDatePickerIndexPath = NSIndexPath(forRow: 1, inSection: 0)
    private let endDateDisplayIndexPath = NSIndexPath(forRow: 2, inSection: 0)
    private let endDatePickerIndexPath = NSIndexPath(forRow: 3, inSection: 0)
    
    //MARK: - Dependencies
    
    var account: Account!
    var categoryStore: CategoryStore!
    var formatter: AccountsFormatter!
    
    //MARK: - Outlets
    
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var generateButton: UIButton!
    
    //MARK: - Actions
    
    @IBAction func dateChanged() {
        startDateLabel.text = formatter.dateStringFrom(startDatePicker.date)
        endDateLabel.text = formatter.dateStringFrom(endDatePicker.date)
        
        generateButton.enabled = (endDatePicker.date >= startDatePicker.date)
    }
    
    @IBAction func generatePressed(sender: UIButton) {
        //TODO: generate report & perform segue
    }
    
    //MARK: - Table view functions
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath == startDateDisplayIndexPath {
            setStartDatePickerVisible(!startDatePickerVisible)
            setEndDatePickerVisible(false)
        } else if indexPath == endDateDisplayIndexPath {
            setEndDatePickerVisible(!endDatePickerVisible)
            setStartDatePickerVisible(false)
        } else {
            setStartDatePickerVisible(false)
            setEndDatePickerVisible(false)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (!startDatePickerVisible && indexPath == startDatePickerIndexPath)
            || (!endDatePickerVisible && indexPath == endDatePickerIndexPath) {
            return 0
        } else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    //MARK: - Private functions
    
    private func setStartDatePickerVisible(visible: Bool) {
        tableView.beginUpdates()
        startDatePickerVisible = visible
        tableView.endUpdates()
    }
    
    private func setEndDatePickerVisible(visible: Bool) {
        tableView.beginUpdates()
        endDatePickerVisible = visible
        tableView.endUpdates()
    }
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateChanged()
    }

}

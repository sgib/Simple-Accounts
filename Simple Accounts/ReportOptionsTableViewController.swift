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
    
    //MARK: - Dependencies
    
    var account: Account!
    var categoryStore: CategoryStore!
    var formatter: AccountsFormatter!
    
    //MARK: - Outlets
    
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    //MARK: - Actions
    
    @IBAction func dateChanged() {
        startDateLabel.text = formatter.dateStringFrom(startDatePicker.date)
        endDateLabel.text = formatter.dateStringFrom(endDatePicker.date)
    }
    
    @IBAction func generatePressed(sender: UIButton) {
        //TODO: check startDate <= endDate, generate report, but only segue to reportList if report is not empty
        //so if any of above isn't correct then display 'error message'
    }
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateChanged()
    }

}

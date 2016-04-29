//
//  RangePickerViewController.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 28/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

protocol TransactionRangePickerDelegate: class {
    func rangePicker(rangePicker: RangePickerViewController, didChangeRangeSizeTo rangeSize: StandardTransactionDateRange.Size)
}

class RangePickerViewController: UIViewController {

    //MARK: - Dependencies
    
    var size: StandardTransactionDateRange.Size!
    weak var delegate: TransactionRangePickerDelegate?
    
    //MARK: - Outlets
    
    @IBOutlet weak var rangeSegmentControl: UISegmentedControl!
    
    //MARK: - Actions
    
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        size = StandardTransactionDateRange.Size.allCases[rangeSegmentControl.selectedSegmentIndex]
        delegate?.rangePicker(self, didChangeRangeSizeTo: size)
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rangeSegmentControl.removeAllSegments()
        let ranges = StandardTransactionDateRange.Size.allCases
        for index in 0..<ranges.count {
            rangeSegmentControl.insertSegmentWithTitle(ranges[index].description, atIndex: index, animated: false)
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if let selectedIndex = StandardTransactionDateRange.Size.allCases.indexOf(size) {
            rangeSegmentControl.selectedSegmentIndex = selectedIndex
        }
    }
}

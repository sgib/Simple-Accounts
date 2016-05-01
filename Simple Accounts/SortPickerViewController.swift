//
//  SortPickerViewController.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 28/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

protocol TransactionSortPickerDelegate: class {
    func sortPicker(sortPicker: SortPickerViewController, didChangeSortTo sortType: TransactionSortType)
}

class SortPickerViewController: UIViewController {

    //MARK: Dependencies
    
    var sortOptions: [TransactionSortType] = TransactionSortType.allCases
    var sortType: TransactionSortType!
    weak var delegate: TransactionSortPickerDelegate?
    
    //MARK: - Outlets
    
    @IBOutlet weak var sortPicker: UIPickerView!
    
    //MARK: - View lifecycle
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let selectedRow = sortOptions.indexOf(sortType) {
            sortPicker.selectRow(selectedRow, inComponent: 0, animated: true)
        }
    }

}

//MARK: - Sort picker data source
extension SortPickerViewController: UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortOptions.count
    }
}

//MARK: - Sort picker delegate
extension SortPickerViewController: UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortOptions[row].description
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sortType = sortOptions[row]
        delegate?.sortPicker(self, didChangeSortTo: sortType)
    }
}

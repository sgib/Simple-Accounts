//
//  CurrencyTextField.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 19/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class CurrencyTextField: UITextField {

    var enteredAmount: Money = Money.zero() {
        didSet {
            if !editing {
                enteredAmount = enteredAmount.moneyRoundedToTwoDecimalPlaces()
                updateTextDisplay()
            }
        }
    }
    
    //MARK: - Dependencies
    
    var formatter: AccountsFormatter! {
        didSet {
            placeholder = formatter.currencyStringFrom(Money.zero())
        }
    }
    
    //MARK: Private functions
    
    @objc private func editingChanged() {
        let inputAmount = Money(string: unwrappedText)
        enteredAmount = (inputAmount == Money.notANumber()) ? Money.zero() : inputAmount
    }
    
    private func updateTextDisplay() {
        text = formatter.currencyStringFrom(enteredAmount)
    }

    //MARK: - View lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        delegate = self
        addTarget(self, action: #selector(editingChanged), forControlEvents: .EditingChanged)
    }
}

//MARK: - Text field delegate
extension CurrencyTextField: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let combinedStrings = (textField.unwrappedText as NSString).stringByReplacingCharactersInRange(range, withString: string)
        guard combinedStrings.occurrencesOfSubstring(".") <= 1 else {
            return false
        }
        let newCharacters = NSCharacterSet(charactersInString: string)
        let allowedInput = NSCharacterSet(charactersInString: "0123456789.")
        return allowedInput.isSupersetOfSet(newCharacters)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = (enteredAmount != Money.zero()) ? "\(enteredAmount)" : ""
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        updateTextDisplay()
    }
    

}
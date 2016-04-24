//
//  Extensions.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 10/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

extension Array {
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
}

extension String {
    func occurrencesOfSubstring(substring: String) -> Int {
        return self.componentsSeparatedByString(substring).count - 1
    }
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
}

extension UIImage {
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.width)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(CGImage: image.CGImage!)
    }
}

extension UILabel {
    func setTextToMoneyAmount(amount: Money, usingFormatter formatter: AccountsFormatter) {
        textColor = amount.isNegative ? formatter.negativeAmountColour : formatter.positiveAmountColour
        text = formatter.currencyStringFrom(amount.absoluteValue)
    }
}

extension UITextField {
    var unwrappedText: String {
        return self.text ?? ""
    }
}
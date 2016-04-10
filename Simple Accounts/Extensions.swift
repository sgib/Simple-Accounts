//
//  Extensions.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 10/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

extension String {
    func occurrencesOfSubstring(substring: String) -> Int {
        return self.componentsSeparatedByString(substring).count - 1
    }
}

extension UITextField {
    var unwrappedText: String {
        return self.text ?? ""
    }
}
//
//  Money.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 22/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import Foundation

typealias Money = NSDecimalNumber

func +(left: Money, right: Money) -> Money {
    return left.decimalNumberByAdding(right)
}

func -(left: Money, right: Money) -> Money {
    return left.decimalNumberBySubtracting(right)
}

func *(left: Money, right: Money) -> Money {
    return left.decimalNumberByMultiplyingBy(right)
}

extension Money {
    func moneyRoundedToTwoDecimalPlaces() -> Money {
        let handler = NSDecimalNumberHandler(roundingMode: .RoundPlain,
                                             scale: 2,
                                             raiseOnExactness: false,
                                             raiseOnOverflow: false,
                                             raiseOnUnderflow: false,
                                             raiseOnDivideByZero: true)
        return self.decimalNumberByRoundingAccordingToBehavior(handler)
    }
}
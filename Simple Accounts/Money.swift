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

func /(left: Money, right: Money) -> Money {
    return left.decimalNumberByDividingBy(right)
}

func > (left:NSDecimalNumber, right:NSDecimalNumber) -> Bool
{
    return left.compare(right) == .OrderedDescending
}

func < (left:NSDecimalNumber, right:NSDecimalNumber) -> Bool
{
    return left.compare(right) == .OrderedAscending
}

func >= (left:NSDecimalNumber, right:NSDecimalNumber) -> Bool
{
    return left > right || left == right
}

func <= (left:NSDecimalNumber, right:NSDecimalNumber) -> Bool
{
    return left < right || left == right
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
    
    var isPositive: Bool {
        return self > Money.zero()
    }
    
    var isNegative: Bool {
        return self < Money.zero()
    }
    
    var absoluteValue: Money {
        return isNegative ? Money.zero() - self : self
    }
}
//
//  TransactionTests.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 22/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import XCTest
@testable import Simple_Accounts

class TransactionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSignedAmount() {
        let absoluteAmount = Money(integer: 35)
        let negativeAmount = absoluteAmount.decimalNumberByMultiplyingBy(Money(integer: -1))
        let trans = Transaction(amount: absoluteAmount , category: TransactionCategory(name: "", icon: 0), date: NSDate(), type: .Income, description: nil)
        XCTAssertEqual(trans.signedAmount, absoluteAmount)
        trans.type = .Expense
        XCTAssertEqual(trans.signedAmount, negativeAmount)
    }
    
    func testLongAmountCorrectlyRoundedWhenTransactionCreated() {
        let manydecimalPlacesAmount = Money(double: 123.456789)
        let trans = Transaction(amount: manydecimalPlacesAmount , category: TransactionCategory(name: "", icon: 0), date: NSDate(), type: .Income, description: nil)
        XCTAssertEqual(trans.amount, Money(string: "123.46"))
    }
    
    func testLongAmountCorrectlyRoundedWhenAmountChanged() {
        let manydecimalPlacesAmount = Money(double: 123.456789)
        let trans = Transaction(amount: Money.zero() , category: TransactionCategory(name: "", icon: 0), date: NSDate(), type: .Income, description: nil)
        trans.amount = manydecimalPlacesAmount
        XCTAssertEqual(trans.amount, Money(string: "123.46"))
    }
}
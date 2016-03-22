//
//  AccountTests.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 22/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import XCTest
@testable import Simple_Accounts

class AccountTests: XCTestCase {

    private let openingAmount = Money(integer: 111)
    private var account: Account!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        account = Account(openingBalance: openingAmount)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAccountCreation() {
        XCTAssertEqual(account.currentBalance, openingAmount)
    }
    
    func testAddIncomeTransactionIncreasesCurrentBalance() {
        let transAmount = Money(integer: 38)
        let trans = Transaction(amount: transAmount, category: TransactionCategory(name: "", icon: 0), date: NSDate(), type: .Income, description: nil)
        account.addTransaction(trans)
        
        XCTAssertEqual(account.currentBalance, openingAmount + transAmount)
    }
    
    func testAddExpenseTransactionDecreasesCurrentBalance() {
        let transAmount = Money(integer: 38)
        let trans = Transaction(amount: transAmount, category: TransactionCategory(name: "", icon: 0), date: NSDate(), type: .Expense, description: nil)
        account.addTransaction(trans)
        
        XCTAssertEqual(account.currentBalance, openingAmount - transAmount)
    }
}

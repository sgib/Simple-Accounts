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

    private let calendar = NSCalendar.currentCalendar()
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
    
    func testGetTransactionsForMonth() {
        let dateComp = NSDateComponents()
        dateComp.month = 2
        dateComp.year = 2106
        let trans1 = Transaction(amount: Money.zero(), category: TransactionCategory(name: "", icon: 0),
                                 date: calendar.dateFromComponents(dateComp)!, type: .Expense, description: nil)
        dateComp.month = 3
        let trans2 = Transaction(amount: Money(integer: 24), category: TransactionCategory(name: "", icon: 0),
                                 date: calendar.dateFromComponents(dateComp)!, type: .Expense, description: nil)
        let trans3 = Transaction(amount: Money(integer: 53), category: TransactionCategory(name: "", icon: 0),
                                 date: calendar.dateFromComponents(dateComp)!, type: .Expense, description: nil)
        account.addTransaction(trans1)
        account.addTransaction(trans2)
        account.addTransaction(trans3)
        
        XCTAssertEqual(account.transactionsForMonth(calendar.dateFromComponents(dateComp)!), [trans2, trans3])
    }
    
    func testGetOpeningBalanceForMonth() {
        let dateComp = NSDateComponents()
        dateComp.month = 2
        dateComp.year = 2106
        let trans1 = Transaction(amount: Money(integer: 49), category: TransactionCategory(name: "", icon: 0),
                                 date: calendar.dateFromComponents(dateComp)!, type: .Expense, description: nil)
        dateComp.month = 3
        let trans2 = Transaction(amount: Money(integer: 24), category: TransactionCategory(name: "", icon: 0),
                                 date: calendar.dateFromComponents(dateComp)!, type: .Expense, description: nil)
        account.addTransaction(trans1)
        account.addTransaction(trans2)
        
        XCTAssertEqual(account.balanceAtStartOfMonth(calendar.dateFromComponents(dateComp)!), openingAmount + trans1.signedAmount)
    }
}

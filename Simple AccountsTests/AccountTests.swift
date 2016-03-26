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

    private let coreDataHelper = CoreDataTestHelper(accountOpeningBalance: Money.zero())
    private let calendar = NSCalendar.currentCalendar()
    private let openingAmount = Money(integer: 111)
    private var defaultCategory: TransactionCategory!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coreDataHelper.resetData()
        defaultCategory = coreDataHelper.categoryStore.addCategory(TransactionCategoryData(name: "default", icon: 0))
        coreDataHelper.account.openingBalance = openingAmount
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAccountCreation() {
        XCTAssertEqual(coreDataHelper.account.currentBalance, openingAmount)
    }
    
    func testAddIncomeTransactionIncreasesCurrentBalance() {
        let transAmount = Money(integer: 38)
        coreDataHelper.account.addTransaction(TransactionData(amount: transAmount, category: defaultCategory, date: NSDate(), description: nil, type: .Income))
        
        XCTAssertEqual(coreDataHelper.account.currentBalance, openingAmount + transAmount)
    }
    
    func testAddExpenseTransactionDecreasesCurrentBalance() {
        let transAmount = Money(integer: 38)
        coreDataHelper.account.addTransaction(TransactionData(amount: transAmount, category: defaultCategory, date: NSDate(), description: nil, type: .Expense))
        
        XCTAssertEqual(coreDataHelper.account.currentBalance, openingAmount - transAmount)
    }
    
    func testGetTransactionsForMonth() {
        let dateComp = NSDateComponents()
        dateComp.month = 2
        dateComp.year = 2016
        _ = coreDataHelper.account.addTransaction(TransactionData(amount: Money.zero(), category: defaultCategory,
                                 date: calendar.dateFromComponents(dateComp)!, description: nil, type: .Expense))
        dateComp.month = 3
        let trans2 = coreDataHelper.account.addTransaction(TransactionData(amount: Money(integer: 24), category: defaultCategory,
                                 date: calendar.dateFromComponents(dateComp)!, description: nil, type: .Expense))
        let trans3 = coreDataHelper.account.addTransaction(TransactionData(amount: Money(integer: 53), category: defaultCategory,
                                 date: calendar.dateFromComponents(dateComp)!, description: nil, type: .Expense))
        let date = calendar.dateFromComponents(dateComp)!
        XCTAssertEqual(coreDataHelper.account.transactionsForMonth(date).count, [trans2, trans3].count)
    }
    
    func testGetOpeningBalanceForMonth() {
        let dateComp = NSDateComponents()
        dateComp.month = 2
        dateComp.year = 2016
        let trans1 = coreDataHelper.account.addTransaction(TransactionData(amount: Money(integer: 49), category: defaultCategory,
                                 date: calendar.dateFromComponents(dateComp)!, description: nil, type: .Expense))
        dateComp.month = 3
        _ = coreDataHelper.account.addTransaction(TransactionData(amount: Money(integer: 24), category: defaultCategory,
                                 date: calendar.dateFromComponents(dateComp)!, description: nil, type: .Expense))
        let date = calendar.dateFromComponents(dateComp)!
        XCTAssertEqual(coreDataHelper.account.balanceAtStartOfMonth(date), openingAmount + trans1.signedAmount)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        for _ in 1...5000 {
            self.coreDataHelper.account.addTransaction(TransactionData(amount: Money(integer: 53), category: self.defaultCategory,
                date: NSDate(), description: nil, type: .Expense))
        }
        self.measureBlock {
            // Put the code you want to measure the time of here.
            print(self.coreDataHelper.account.currentBalance)
        }
    }
}












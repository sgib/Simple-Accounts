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

    private let coreDataHelper = CoreDataTestHelper.sharedInstance
    private let openingAmount = Money(integer: 111)
    private var defaultCategory: TransactionCategory!
    private let februaryDate = TransactionDate.dateFrom(day: 13, month: 2, year: 2016)!
    private let marchDate = TransactionDate.dateFrom(day: 17, month: 3, year: 2016)!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coreDataHelper.resetData()
        defaultCategory = coreDataHelper.categoryStore.addCategory(TransactionCategoryData(name: "default", icon: "default"))
        coreDataHelper.account.openingBalance = openingAmount
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        coreDataHelper.resetData()
    }
    
    func testAccountCreation() {
        XCTAssertEqual(openingAmount, coreDataHelper.account.currentBalance)
    }
    
    func testAddIncomeTransactionIncreasesCurrentBalance() {
        let transAmount = Money(integer: 38)
        coreDataHelper.account.addTransaction(TransactionData(amount: transAmount,
            category: defaultCategory,
            date: TransactionDate(),
            description: nil,
            type: .Income))
        XCTAssertEqual(openingAmount + transAmount, coreDataHelper.account.currentBalance)
    }
    
    func testAddExpenseTransactionDecreasesCurrentBalance() {
        let transAmount = Money(integer: 38)
        coreDataHelper.account.addTransaction(TransactionData(amount: transAmount,
            category: defaultCategory,
            date: TransactionDate(),
            description: nil,
            type: .Expense))
        XCTAssertEqual(openingAmount - transAmount, coreDataHelper.account.currentBalance)
    }
    
    func testGetTransactionsForRangeCorrectForMonth() {
        coreDataHelper.account.addTransaction(TransactionData(amount: Money(integer: 37),
            category: defaultCategory,
            date: februaryDate,
            description: nil,
            type: .Expense))
        let trans2 = coreDataHelper.account.addTransaction(TransactionData(amount: Money(integer: 24),
            category: defaultCategory,
            date: marchDate,
            description: nil,
            type: .Income))
        let trans3 = coreDataHelper.account.addTransaction(TransactionData(amount: Money(integer: 53),
            category: defaultCategory,
            date: marchDate,
            description: nil,
            type: .Expense))
        let marchRange = TransactionDateRange.rangeFromDate(marchDate, withSize: .Month)
        XCTAssertEqual([trans2, trans3], coreDataHelper.account.transactionsForRange(marchRange))
    }
    
    func testGetOpeningBalanceForRangeCorrectForMonth() {
        let trans1 = coreDataHelper.account.addTransaction(TransactionData(amount: Money(integer: 49),
            category: defaultCategory,
            date: februaryDate,
            description: nil,
            type: .Expense))
        coreDataHelper.account.addTransaction(TransactionData(amount: Money(integer: 24),
            category: defaultCategory,
            date: marchDate,
            description: nil,
            type: .Expense))
        let marchRange = TransactionDateRange.rangeFromDate(marchDate, withSize: .Month)
        XCTAssertEqual(openingAmount + trans1.signedAmount, coreDataHelper.account.balanceAtStartOfRange(marchRange))
    }
    
    func testUpdateTransactionIsSucessful() {
        let trans = coreDataHelper.account.addTransaction(TransactionData(amount: Money.zero(),
            category: defaultCategory,
            date: TransactionDate.Today,
            description: nil,
            type: .Income))
        let newAmount = Money(integer: 33)
        let newDate = TransactionDate.dateFrom(day: 13, month: 4, year: 2016)!
        let newDescription = "new description"
        let newType = TransactionType.Expense
        trans.amount = newAmount
        trans.date = newDate
        trans.transactionDescription = newDescription
        trans.type = newType
        coreDataHelper.account.updateTransaction(trans)
        let range = TransactionDateRange.rangeFromDate(newDate, withSize: .Week)
        let retrievedTrans = coreDataHelper.account.transactionsForRange(range).first!
        XCTAssertEqual(newAmount, retrievedTrans.amount)
        XCTAssertEqual(newDate, retrievedTrans.date)
        XCTAssertEqual(newDescription, retrievedTrans.transactionDescription)
        XCTAssertEqual(newType, retrievedTrans.type)
    }
    
    func testDeleteTransactionIsSucessful() {
        let trans = coreDataHelper.account.addTransaction(TransactionData(amount: Money.zero(),
            category: defaultCategory,
            date: TransactionDate.Today,
            description: nil,
            type: .Income))
        let currentMonthRange = TransactionDateRange.rangeFromDate(TransactionDate.Today, withSize: .Month)
        XCTAssertEqual(1, coreDataHelper.account.transactionsForRange(currentMonthRange).count)
        coreDataHelper.account.deleteTransaction(trans)
        XCTAssertEqual(0, coreDataHelper.account.transactionsForRange(currentMonthRange).count)
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        for _ in 1...5000 {
//            self.coreDataHelper.account.addTransaction(TransactionData(amount: Money(integer: 53), category: self.defaultCategory,
//                date: NSDate(), description: nil, type: .Expense))
//        }
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//            print(self.coreDataHelper.account.currentBalance)
//        }
//    }
}












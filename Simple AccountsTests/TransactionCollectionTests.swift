//
//  Simple_AccountsTests.swift
//  Simple AccountsTests
//
//  Created by Steven Gibson on 19/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import XCTest
@testable import Simple_Accounts

class TransactionCollectionTests: XCTestCase {
    
    private let coreDataHelper = CoreDataTestHelper.sharedInstance
    private var transCollection: TransactionCollection!
    private var incomeTotal = Money.zero()
    private var expenseTotal = Money.zero()
    private var aggregateTotal = Money.zero()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        coreDataHelper.resetData()
        let defaultCategory = coreDataHelper.categoryStore.addCategory(TransactionCategoryData(name: "default", icon: "default"))!
        let incomeAmounts = [Money(integer: 55), Money(integer: 37)]
        let expenseAmounts = [Money(integer: 44)]
        incomeTotal = incomeAmounts.reduce(Money.zero(), combine: +)
        expenseTotal = expenseAmounts.reduce(Money.zero(), combine: +)
        aggregateTotal = incomeTotal - expenseTotal
        let transData1 = TransactionData(amount: incomeAmounts[0], category: defaultCategory, date: TransactionDate(), description: nil, type: .Income)
        let transData2 = TransactionData(amount: expenseAmounts[0], category: defaultCategory, date: TransactionDate(), description: nil, type: .Expense)
        let transData3 = TransactionData(amount: incomeAmounts[1], category: defaultCategory, date: TransactionDate(), description: nil, type: .Income)
        let trans1 = coreDataHelper.account.addTransaction(transData1)
        let trans2 = coreDataHelper.account.addTransaction(transData2)
        let trans3 = coreDataHelper.account.addTransaction(transData3)

        transCollection = [trans1, trans2, trans3]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        coreDataHelper.resetData()
    }
    
    func testCollectionSumIncome() {
        XCTAssertTrue(transCollection.sumIncome == incomeTotal)
    }
    
    func testCollectionSumExpenses() {
        XCTAssertTrue(transCollection.sumExpenses == expenseTotal)
    }
    
    func testCollectionSumAggregate() {
        XCTAssertTrue(transCollection.sumAggregate == aggregateTotal)
    }
    
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}

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
    
    private var transCollection: TransactionCollection!
    private var incomeTotal = Money.zero()
    private var expenseTotal = Money.zero()
    private var aggregateTotal = Money.zero()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let defaultCategory = TransactionCategory(name: "default", icon: 0)
        let incomeAmounts = [NSDecimalNumber(integer: 55), NSDecimalNumber(integer: 37)]
        let expenseAmounts = [NSDecimalNumber(integer: 44)]
        incomeTotal = incomeAmounts.reduce(Money.zero(), combine: +)
        expenseTotal = expenseAmounts.reduce(Money.zero(), combine: +)
        aggregateTotal = incomeTotal - expenseTotal
        let trans1 = Transaction(amount: incomeAmounts[0], category: defaultCategory, date: NSDate(), type: .Income, description: nil)
        let trans2 = Transaction(amount: expenseAmounts[0], category: defaultCategory, date: NSDate(), type: .Expense, description: nil)
        let trans3 = Transaction(amount: incomeAmounts[1], category: defaultCategory, date: NSDate(), type: .Income, description: nil)

        transCollection = [trans1, trans2, trans3]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}

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
    private let coreDataHelper = CoreDataTestHelper.sharedInstance
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coreDataHelper.resetData()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        coreDataHelper.resetData()
    }
    
    func testSignedAmount() {
        let absoluteAmount = Money(integer: 35)
        let negativeAmount = absoluteAmount.decimalNumberByMultiplyingBy(Money(integer: -1))
        let category = coreDataHelper.categoryStore.addCategory(TransactionCategoryData(name: "test", icon: "test"))!
        let transData = TransactionData(amount: absoluteAmount, category: category, date: TransactionDate(), description: nil, type: .Income)
        let trans = coreDataHelper.account.addTransaction(transData)
        XCTAssertEqual(absoluteAmount, trans.signedAmount)
        trans.type = .Expense
        XCTAssertEqual(negativeAmount, trans.signedAmount)
    }
}
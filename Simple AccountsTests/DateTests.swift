//
//  DateTests.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 26/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import XCTest
@testable import Simple_Accounts

class DateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testStartOfMonth() {
        let month = 7
        let year = 2016
        var date = TransactionDate.creatDateFrom(day: 4, month: month, year: year)!
        let startDate = date.dateAtTheStartOfMonth()
        date = TransactionDate.creatDateFrom(day: 1, month: month, year: year)!
        XCTAssertEqual(date, startDate)
    }

    func testEndOfMonth() {
        let month = 7
        let year = 2016
        var date = TransactionDate.creatDateFrom(day: 4, month: month, year: year)!
        let startDate = date.dateAtTheEndOfMonth()
        date = TransactionDate.creatDateFrom(day: 31, month: month, year: year)!
        XCTAssertEqual(date, startDate)
    }

}

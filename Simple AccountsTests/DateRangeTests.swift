//
//  DateRangeTests.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 05/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import XCTest
@testable import Simple_Accounts

class DateRangeTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWeekRangeIsCorrectForCurrentWeek() {
        let currentDate = TransactionDate.dateFrom(day: 7, month: 4, year: 2016)!
        let expectedStartDate = TransactionDate.dateFrom(day: 3, month: 4, year: 2016)!
        let expectedEndDate = TransactionDate.dateFrom(day: 9, month: 4, year: 2016)!
        let actual = TransactionDateRange.rangeFromDate(currentDate, withSize: .Week, weeksStartsOn: .Sunday)
        XCTAssertEqual(expectedStartDate, actual.startDate)
        XCTAssertEqual(expectedEndDate, actual.endDate)
    }
    
    func testWeekRangeIsCorrectForPreviousWeekFromCurrentWeek() {
        let currentDate = TransactionDate.dateFrom(day: 7, month: 4, year: 2016)!
        let expectedStartDate = TransactionDate.dateFrom(day: 27, month: 3, year: 2016)!
        let expectedEndDate = TransactionDate.dateFrom(day: 2, month: 4, year: 2016)!
        let currentWeek = TransactionDateRange.rangeFromDate(currentDate, withSize: .Week, weeksStartsOn: .Sunday)
        let actual = currentWeek.previous()
        XCTAssertEqual(expectedStartDate, actual.startDate)
        XCTAssertEqual(expectedEndDate, actual.endDate)
    }
    
    func testWeekRangeIsCorrectForNextWeekFromCurrentWeek() {
        let currentDate = TransactionDate.dateFrom(day: 7, month: 4, year: 2016)!
        let expectedStartDate = TransactionDate.dateFrom(day: 10, month: 4, year: 2016)!
        let expectedEndDate = TransactionDate.dateFrom(day: 16, month: 4, year: 2016)!
        let currentWeek = TransactionDateRange.rangeFromDate(currentDate, withSize: .Week, weeksStartsOn: .Sunday)
        let actual = currentWeek.next()
        XCTAssertEqual(expectedStartDate, actual.startDate)
        XCTAssertEqual(expectedEndDate, actual.endDate)
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }

}

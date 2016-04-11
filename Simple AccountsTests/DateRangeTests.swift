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
        TransactionCalendar.sharedCalendar.changeFirstWeekdayTo(.Sunday)
    }
    
    override func tearDown() {
        TransactionCalendar.sharedCalendar.changeFirstWeekdayTo(.Sunday)
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWeekRangeIsCorrectForCurrentWeek() {
        let currentDate = TransactionDate.dateFrom(day: 7, month: 4, year: 2016)!
        let expectedStartDate = TransactionDate.dateFrom(day: 3, month: 4, year: 2016)!
        let expectedEndDate = TransactionDate.dateFrom(day: 9, month: 4, year: 2016)!
        let actual = TransactionDateRange.rangeFromDate(currentDate, withSize: .Week)
        XCTAssertEqual(expectedStartDate, actual.startDate)
        XCTAssertEqual(expectedEndDate, actual.endDate)
    }
    
    func testWeekRangeIsCorrectForPreviousWeekFromCurrentWeek() {
        let currentDate = TransactionDate.dateFrom(day: 7, month: 4, year: 2016)!
        let expectedStartDate = TransactionDate.dateFrom(day: 27, month: 3, year: 2016)!
        let expectedEndDate = TransactionDate.dateFrom(day: 2, month: 4, year: 2016)!
        let currentWeek = TransactionDateRange.rangeFromDate(currentDate, withSize: .Week)
        let actual = currentWeek.previous()
        XCTAssertEqual(expectedStartDate, actual.startDate)
        XCTAssertEqual(expectedEndDate, actual.endDate)
    }
    
    func testWeekRangeIsCorrectForNextWeekFromCurrentWeek() {
        let currentDate = TransactionDate.dateFrom(day: 7, month: 4, year: 2016)!
        let expectedStartDate = TransactionDate.dateFrom(day: 10, month: 4, year: 2016)!
        let expectedEndDate = TransactionDate.dateFrom(day: 16, month: 4, year: 2016)!
        let currentWeek = TransactionDateRange.rangeFromDate(currentDate, withSize: .Week)
        let actual = currentWeek.next()
        XCTAssertEqual(expectedStartDate, actual.startDate)
        XCTAssertEqual(expectedEndDate, actual.endDate)
    }
    
    func testMonthRangeIsCorrectForCurrentMonth() {
        let currentDate = TransactionDate.dateFrom(day: 7, month: 4, year: 2016)!
        let expectedStartDate = TransactionDate.dateFrom(day: 1, month: 4, year: 2016)!
        let expectedEndDate = TransactionDate.dateFrom(day: 30, month: 4, year: 2016)!
        let actual = TransactionDateRange.rangeFromDate(currentDate, withSize: .Month)
        XCTAssertEqual(expectedStartDate, actual.startDate)
        XCTAssertEqual(expectedEndDate, actual.endDate)
    }
    
    func testMonthRangeIsCorrectForPreviousMonthFromCurrentMonth() {
        let currentDate = TransactionDate.dateFrom(day: 7, month: 4, year: 2016)!
        let expectedStartDate = TransactionDate.dateFrom(day: 1, month: 3, year: 2016)!
        let expectedEndDate = TransactionDate.dateFrom(day: 31, month: 3, year: 2016)!
        let currentMonth = TransactionDateRange.rangeFromDate(currentDate, withSize: .Month)
        let actual = currentMonth.previous()
        XCTAssertEqual(expectedStartDate, actual.startDate)
        XCTAssertEqual(expectedEndDate, actual.endDate)
    }
    
    func testMonthRangeIsCorrectForNextMonthFromCurrentMonth() {
        let currentDate = TransactionDate.dateFrom(day: 7, month: 4, year: 2016)!
        let expectedStartDate = TransactionDate.dateFrom(day: 1, month: 5, year: 2016)!
        let expectedEndDate = TransactionDate.dateFrom(day: 31, month: 5, year: 2016)!
        let currentMonth = TransactionDateRange.rangeFromDate(currentDate, withSize: .Month)
        let actual = currentMonth.next()
        XCTAssertEqual(expectedStartDate, actual.startDate)
        XCTAssertEqual(expectedEndDate, actual.endDate)
    }
    
    func testYearRangeIsCorrectForCurrentYear() {
        let currentDate = TransactionDate.dateFrom(day: 7, month: 4, year: 2016)!
        let expectedStartDate = TransactionDate.dateFrom(day: 1, month: 1, year: 2016)!
        let expectedEndDate = TransactionDate.dateFrom(day: 31, month: 12, year: 2016)!
        let actual = TransactionDateRange.rangeFromDate(currentDate, withSize: .Year)
        XCTAssertEqual(expectedStartDate, actual.startDate)
        XCTAssertEqual(expectedEndDate, actual.endDate)
    }
    
    func testYearRangeIsCorrectForPreviousYearFromCurrentYear() {
        let currentDate = TransactionDate.dateFrom(day: 7, month: 4, year: 2016)!
        let expectedStartDate = TransactionDate.dateFrom(day: 1, month: 1, year: 2015)!
        let expectedEndDate = TransactionDate.dateFrom(day: 31, month: 12, year: 2015)!
        let currentYear = TransactionDateRange.rangeFromDate(currentDate, withSize: .Year)
        let actual = currentYear.previous()
        XCTAssertEqual(expectedStartDate, actual.startDate)
        XCTAssertEqual(expectedEndDate, actual.endDate)
    }
    
    func testYearRangeIsCorrectForNextYearFromCurrentYear() {
        let currentDate = TransactionDate.dateFrom(day: 7, month: 4, year: 2016)!
        let expectedStartDate = TransactionDate.dateFrom(day: 1, month: 1, year: 2017)!
        let expectedEndDate = TransactionDate.dateFrom(day: 31, month: 12, year: 2017)!
        let currentYear = TransactionDateRange.rangeFromDate(currentDate, withSize: .Year)
        let actual = currentYear.next()
        XCTAssertEqual(expectedStartDate, actual.startDate)
        XCTAssertEqual(expectedEndDate, actual.endDate)
    }
    
    func testRangeContainsDateIsCorrectForWeekRange() {
        let currentDate = TransactionDate.dateFrom(day: 11, month: 4, year: 2016)!
        let dateInCurrentWeek = TransactionDate.dateFrom(day: 16, month: 4, year: 2016)!
        let earlierDate = TransactionDate.dateFrom(day: 9, month: 4, year: 2016)!
        let laterDate = TransactionDate.dateFrom(day: 17, month: 4, year: 2016)!
        let currentWeek = TransactionDateRange.rangeFromDate(currentDate, withSize: .Week)
        XCTAssertTrue(currentWeek.contains(dateInCurrentWeek))
        XCTAssertFalse(currentWeek.contains(earlierDate))
        XCTAssertFalse(currentWeek.contains(laterDate))
    }
    
    func testRangeContainsDateIsCorrectForMonthRange() {
        let currentDate = TransactionDate.dateFrom(day: 11, month: 4, year: 2016)!
        let dateInCurrentMonth = TransactionDate.dateFrom(day: 30, month: 4, year: 2016)!
        let earlierDate = TransactionDate.dateFrom(day: 11, month: 4, year: 2015)!
        let laterDate = TransactionDate.dateFrom(day: 1, month: 5, year: 2016)!
        let currentMonth = TransactionDateRange.rangeFromDate(currentDate, withSize: .Month)
        XCTAssertTrue(currentMonth.contains(dateInCurrentMonth))
        XCTAssertFalse(currentMonth.contains(earlierDate))
        XCTAssertFalse(currentMonth.contains(laterDate))
    }
    
    func testRangeContainsDateIsCorrectForYearRange() {
        let currentDate = TransactionDate.dateFrom(day: 11, month: 4, year: 2016)!
        let dateInCurrentYear = TransactionDate.dateFrom(day: 11, month: 11, year: 2016)!
        let earlierDate = TransactionDate.dateFrom(day: 31, month: 12, year: 2015)!
        let laterDate = TransactionDate.dateFrom(day: 1, month: 1, year: 2017)!
        let currentYear = TransactionDateRange.rangeFromDate(currentDate, withSize: .Year)
        XCTAssertTrue(currentYear.contains(dateInCurrentYear))
        XCTAssertFalse(currentYear.contains(earlierDate))
        XCTAssertFalse(currentYear.contains(laterDate))
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }

}






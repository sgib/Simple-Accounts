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
        TransactionCalendar.sharedCalendar.changeFirstWeekdayTo(.Sunday)
    }
    
    override func tearDown() {
        TransactionCalendar.sharedCalendar.changeFirstWeekdayTo(.Sunday)
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfDaysInJanuary() {
        let expected = TransactionDate.dateFrom(day: 31, month: 1, year: 2016)!
        let actual = TransactionDate.dateFrom(day: 13, month: 1, year: 2016)!.dateAtEndOfMonth()
        XCTAssertEqual(expected, actual)
    }
    
    func testNumberOfDaysInFebruary() {
        let expected = TransactionDate.dateFrom(day: 28, month: 2, year: 2015)!
        let actual = TransactionDate.dateFrom(day: 13, month: 2, year: 2015)!.dateAtEndOfMonth()
        XCTAssertEqual(expected, actual)
    }
    
    func testNumberOfDaysInFebruaryLeapYear() {
        let expected = TransactionDate.dateFrom(day: 29, month: 2, year: 2016)!
        let actual = TransactionDate.dateFrom(day: 13, month: 2, year: 2016)!.dateAtEndOfMonth()
        XCTAssertEqual(expected, actual)
    }
    
    func testNumberOfDaysInMarch() {
        let expected = TransactionDate.dateFrom(day: 31, month: 3, year: 2016)!
        let actual = TransactionDate.dateFrom(day: 13, month: 3, year: 2016)!.dateAtEndOfMonth()
        XCTAssertEqual(expected, actual)
    }
    
    func testNumberOfDaysInApril() {
        let expected = TransactionDate.dateFrom(day: 30, month: 4, year: 2016)!
        let actual = TransactionDate.dateFrom(day: 13, month: 4, year: 2016)!.dateAtEndOfMonth()
        XCTAssertEqual(expected, actual)
    }
    
    func testNumberOfDaysInMay() {
        let expected = TransactionDate.dateFrom(day: 31, month: 5, year: 2016)!
        let actual = TransactionDate.dateFrom(day: 13, month: 5, year: 2016)!.dateAtEndOfMonth()
        XCTAssertEqual(expected, actual)
    }
    
    func testNumberOfDaysInJune() {
        let expected = TransactionDate.dateFrom(day: 30, month: 6, year: 2016)!
        let actual = TransactionDate.dateFrom(day: 13, month: 6, year: 2016)!.dateAtEndOfMonth()
        XCTAssertEqual(expected, actual)
    }
    
    func testNumberOfDaysInJuly() {
        let expected = TransactionDate.dateFrom(day: 31, month: 7, year: 2016)!
        let actual = TransactionDate.dateFrom(day: 13, month: 7, year: 2016)!.dateAtEndOfMonth()
        XCTAssertEqual(expected, actual)
    }
    
    func testNumberOfDaysInAugust() {
        let expected = TransactionDate.dateFrom(day: 31, month: 8, year: 2016)!
        let actual = TransactionDate.dateFrom(day: 13, month: 8, year: 2016)!.dateAtEndOfMonth()
        XCTAssertEqual(expected, actual)
    }
    
    func testNumberOfDaysInSeptember() {
        let expected = TransactionDate.dateFrom(day: 30, month: 9, year: 2016)!
        let actual = TransactionDate.dateFrom(day: 13, month: 9, year: 2016)!.dateAtEndOfMonth()
        XCTAssertEqual(expected, actual)
    }
    
    func testNumberOfDaysInOctober() {
        let expected = TransactionDate.dateFrom(day: 31, month: 10, year: 2016)!
        let actual = TransactionDate.dateFrom(day: 13, month: 10, year: 2016)!.dateAtEndOfMonth()
        XCTAssertEqual(expected, actual)
    }
    
    func testNumberOfDaysInNovember() {
        let expected = TransactionDate.dateFrom(day: 30, month: 11, year: 2016)!
        let actual = TransactionDate.dateFrom(day: 13, month: 11, year: 2016)!.dateAtEndOfMonth()
        XCTAssertEqual(expected, actual)
    }
    
    func testNumberOfDaysInDecember() {
        let expected = TransactionDate.dateFrom(day: 31, month: 12, year: 2016)!
        let actual = TransactionDate.dateFrom(day: 13, month: 12, year: 2016)!.dateAtEndOfMonth()
        XCTAssertEqual(expected, actual)
    }

    func testDateAtStartOfWeekCorrectWhenDateWillBePreviousMonth() {
        TransactionCalendar.sharedCalendar.changeFirstWeekdayTo(.Sunday)
        let expected = TransactionDate.dateFrom(day: 29, month: 5, year: 2016)!
        let actual = TransactionDate.dateFrom(day: 1, month: 6, year: 2016)!.dateAtStartOfWeek()
        XCTAssertEqual(expected, actual)
    }

    func testDateAtStartOfWeekCorrectWhenDateWillBePreviousYear() {
        TransactionCalendar.sharedCalendar.changeFirstWeekdayTo(.Monday)
        let expected = TransactionDate.dateFrom(day: 28, month: 12, year: 2015)!
        let actual = TransactionDate.dateFrom(day: 1, month: 1, year: 2016)!.dateAtStartOfWeek()
        XCTAssertEqual(expected, actual)
    }
    
    func testDateAtEndOfWeekCorrectWhenDateWillBeNextMonth() {
        TransactionCalendar.sharedCalendar.changeFirstWeekdayTo(.Tuesday)
        let expected = TransactionDate.dateFrom(day: 4, month: 4, year: 2016)!
        let actual = TransactionDate.dateFrom(day: 31, month: 3, year: 2016)!.dateAtEndOfWeek()
        XCTAssertEqual(expected, actual)
    }
    
    func testDateAtEndOfWeekCorrectWhenDateWillBeNextYear() {
        TransactionCalendar.sharedCalendar.changeFirstWeekdayTo(.Wednesday)
        let expected = TransactionDate.dateFrom(day: 3, month: 1, year: 2017)!
        let actual = TransactionDate.dateFrom(day: 30, month: 12, year: 2016)!.dateAtEndOfWeek()
        XCTAssertEqual(expected, actual)
    }
    
    func testDateAtStartOfWeekCorrectWhenDayOfWeekLessThanStartOfWeek() {
        TransactionCalendar.sharedCalendar.changeFirstWeekdayTo(.Saturday)
        let expected = TransactionDate.dateFrom(day: 2, month: 4, year: 2016)!
        let actual = TransactionDate.dateFrom(day: 6, month: 4, year: 2016)!.dateAtStartOfWeek()
        XCTAssertEqual(expected, actual)
    }
    
    func testDateAtEndOfWeekCorrectWhenDayOfWeekLessThanStartOfWeek() {
        TransactionCalendar.sharedCalendar.changeFirstWeekdayTo(.Thursday)
        let expected = TransactionDate.dateFrom(day: 6, month: 4, year: 2016)!
        let actual = TransactionDate.dateFrom(day: 4, month: 4, year: 2016)!.dateAtEndOfWeek()
        XCTAssertEqual(expected, actual)
    }
    
    func testDateByAddingDaysCorrectWhenAddingMovesToFollowingMonth() {
        let expected = TransactionDate.dateFrom(day: 3, month: 4, year: 2016)!
        let actual = TransactionDate.dateFrom(day: 29, month: 3, year: 2016)!.dateByAddingDays(5)
        XCTAssertEqual(expected, actual)
    }
    
    func testDateByAddingDaysCorrectWhenAddingMovesToPreviousMonth() {
        let expected = TransactionDate.dateFrom(day: 27, month: 2, year: 2016)!
        let actual = TransactionDate.dateFrom(day: 2, month: 3, year: 2016)!.dateByAddingDays(-4)
        XCTAssertEqual(expected, actual)
    }
    
    func testDateByAddingDaysCorrectWhenAddingMovesToFollowingYear() {
        let expected = TransactionDate.dateFrom(day: 5, month: 1, year: 2017)!
        let actual = TransactionDate.dateFrom(day: 28, month: 12, year: 2016)!.dateByAddingDays(8)
        XCTAssertEqual(expected, actual)
    }
    
    func testDateByAddingDaysCorrectWhenAddingMovesToPreviousYear() {
        let expected = TransactionDate.dateFrom(day: 27, month: 12, year: 2015)!
        let actual = TransactionDate.dateFrom(day: 5, month: 1, year: 2016)!.dateByAddingDays(-9)
        XCTAssertEqual(expected, actual)
    }
    
    func testLessThanOfEqualOperatorCorrect() {
        let baseDate = TransactionDate.dateFrom(day: 11, month: 4, year: 2016)!
        let earlierDate = TransactionDate.dateFrom(day: 10, month: 4, year: 2016)!
        let sameDate = TransactionDate.dateFrom(day: 11, month: 4, year: 2016)!
        let laterDate = TransactionDate.dateFrom(day: 12, month: 4, year: 2016)!
        XCTAssertTrue(earlierDate <= baseDate)
        XCTAssertTrue(sameDate <= baseDate)
        XCTAssertFalse(laterDate <= baseDate)
    }
    
    func testGreaterThanOfEqualOperatorCorrect() {
        let baseDate = TransactionDate.dateFrom(day: 11, month: 4, year: 2016)!
        let earlierDate = TransactionDate.dateFrom(day: 10, month: 4, year: 2016)!
        let sameDate = TransactionDate.dateFrom(day: 11, month: 4, year: 2016)!
        let laterDate = TransactionDate.dateFrom(day: 12, month: 4, year: 2016)!
        XCTAssertFalse(earlierDate >= baseDate)
        XCTAssertTrue(sameDate >= baseDate)
        XCTAssertTrue(laterDate >= baseDate)
    }
}












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
    private let calendar = NSCalendar.currentCalendar()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testStartOfMonth() {
        let comps = NSDateComponents()
        comps.year = 2016
        comps.month = 7
        comps.day = 4
        var date = calendar.dateFromComponents(comps)!
        let startDate = date.dateAtTheStartOfMonth()
        comps.day = 1
        date = calendar.dateFromComponents(comps)!
        XCTAssertEqual(date, startDate)
    }

    func testEndOfMonth() {
        let comps = NSDateComponents()
        comps.year = 2016
        comps.month = 7
        comps.day = 4
        var date = calendar.dateFromComponents(comps)!
        let startDate = date.dateAtTheEndOfMonth()
        comps.day = 31
        date = calendar.dateFromComponents(comps)!
        XCTAssertEqual(date, startDate)
    }

}

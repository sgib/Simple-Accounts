//
//  CategoryTests.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 27/03/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import XCTest
@testable import Simple_Accounts

class CategoryTests: XCTestCase {

    private let coreDataHelper = CoreDataTestHelper.sharedInstance
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coreDataHelper.resetData()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCreateSingleCategoryIsSucessful() {
        let category = coreDataHelper.categoryStore.addCategory(TransactionCategoryData(name: "test", icon: 0))
        XCTAssertNotNil(category)
    }
    
    func testCreateSameCategoryTwiceIsUnsucessful() {
        let categoryData = TransactionCategoryData(name: "default", icon: 0)
        coreDataHelper.categoryStore.addCategory(categoryData)
        let duplicateCategory = coreDataHelper.categoryStore.addCategory(categoryData)
        XCTAssertNil(duplicateCategory)
    }
    
    func testCreateSameCategoryCaseInsensitiveIsUnsucessful() {
        let categoryData1 = TransactionCategoryData(name: "default", icon: 0)
        let categoryData2 = TransactionCategoryData(name: "DeFault", icon: 0)
        coreDataHelper.categoryStore.addCategory(categoryData1)
        let duplicateCategory = coreDataHelper.categoryStore.addCategory(categoryData2)
        XCTAssertNil(duplicateCategory)
    }
    
    func testCreateSameCategoryWithWhitespaceIsUnsucessful() {
        let categoryData1 = TransactionCategoryData(name: "default", icon: 0)
        let categoryData2 = TransactionCategoryData(name: " default   ", icon: 0)
        coreDataHelper.categoryStore.addCategory(categoryData1)
        let duplicateCategory = coreDataHelper.categoryStore.addCategory(categoryData2)
        XCTAssertNil(duplicateCategory)
    }
    
    func testCreateCategoryWithEmptyNameIsUnsucessful() {
        let categoryData = TransactionCategoryData(name: " ", icon: 0)
        let emptyCategory = coreDataHelper.categoryStore.addCategory(categoryData)
        XCTAssertNil(emptyCategory)
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }

}

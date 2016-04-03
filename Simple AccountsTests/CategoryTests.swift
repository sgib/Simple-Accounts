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
        
        coreDataHelper.resetData()
    }

    func testCreateSingleCategoryIsSucessful() {
        let category = coreDataHelper.categoryStore.addCategory(TransactionCategoryData(name: "test", icon: "default"))
        XCTAssertNotNil(category)
    }
    
    func testCreateSameCategoryTwiceIsUnsucessful() {
        let categoryData = TransactionCategoryData(name: "default", icon: "default")
        coreDataHelper.categoryStore.addCategory(categoryData)
        let duplicateCategory = coreDataHelper.categoryStore.addCategory(categoryData)
        XCTAssertNil(duplicateCategory)
    }
    
    func testCreateSameCategoryCaseInsensitiveIsUnsucessful() {
        let categoryData1 = TransactionCategoryData(name: "default", icon: "default")
        let categoryData2 = TransactionCategoryData(name: "DeFault", icon: "default")
        coreDataHelper.categoryStore.addCategory(categoryData1)
        let duplicateCategory = coreDataHelper.categoryStore.addCategory(categoryData2)
        XCTAssertNil(duplicateCategory)
    }
    
    func testCreateSameCategoryWithWhitespaceIsUnsucessful() {
        let categoryData1 = TransactionCategoryData(name: "default", icon: "default")
        let categoryData2 = TransactionCategoryData(name: " default   ", icon: "default")
        coreDataHelper.categoryStore.addCategory(categoryData1)
        let duplicateCategory = coreDataHelper.categoryStore.addCategory(categoryData2)
        XCTAssertNil(duplicateCategory)
    }
    
    func testCreateCategoryWithEmptyNameIsUnsucessful() {
        let categoryData = TransactionCategoryData(name: " ", icon: "default")
        let emptyCategory = coreDataHelper.categoryStore.addCategory(categoryData)
        XCTAssertNil(emptyCategory)
    }
    
    func testChangingExistingCategoryNameToDuplictaeIsUnsucessful() {
        let categoryData1 = TransactionCategoryData(name: "default", icon: "default")
        let categoryData2 = TransactionCategoryData(name: "test", icon: "default")
        coreDataHelper.categoryStore.addCategory(categoryData1)
        let duplicateCategory = coreDataHelper.categoryStore.addCategory(categoryData2)
        duplicateCategory!.name = "default"
        XCTAssertFalse(coreDataHelper.categoryStore.updateCategory(duplicateCategory!))
    }
    
    func testDeleteCategoryIsSucessful() {
        let categoryData = TransactionCategoryData(name: "default", icon: "default")
        let category = coreDataHelper.categoryStore.addCategory(categoryData)!
        XCTAssertTrue(coreDataHelper.categoryStore.deleteCategory(category))
    }
    
    func testDeleteCategoryWithTransactionsIsUnsucessful() {
        let categoryData = TransactionCategoryData(name: "default", icon: "default")
        let category = coreDataHelper.categoryStore.addCategory(categoryData)!
        let transData = TransactionData(amount: Money.zero(), category: category, date: TransactionDate(), description: nil, type: .Income)
        coreDataHelper.account.addTransaction(transData)
        XCTAssertFalse(coreDataHelper.categoryStore.deleteCategory(category))
    }
    
    func testDeleteCategoryIsPersisted() {
        let categoryData = TransactionCategoryData(name: "default", icon: "default")
        let category = coreDataHelper.categoryStore.addCategory(categoryData)!
        let categoryData2 = TransactionCategoryData(name: "second", icon: "default")
        let category2 = coreDataHelper.categoryStore.addCategory(categoryData2)!
        coreDataHelper.categoryStore.deleteCategory(category)
        category2.name = ""
        //trigger 'rollback' to see if deletion is rolled back
        XCTAssertFalse(coreDataHelper.categoryStore.updateCategory(category2))
        //if deletion was rolled back then count would be 2
        XCTAssertTrue(coreDataHelper.categoryStore.allCategories().count == 1)
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }

}








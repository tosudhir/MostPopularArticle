//
//  MostPopularArticleUITests.swift
//  MostPopularArticleUITests
//
//  Created by Sudhir Kumar on 12/11/20.
//

import XCTest

class MostPopularArticleUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        app.launch()
        continueAfterFailure = false
    }
    
    func testArticleViewControllUILoaded() {
        XCTAssertEqual(app.tables.count, 1)
        XCTAssertTrue(app.navigationBars["Articles"].staticTexts["Articles"].exists)
        let table = app.tables.element(boundBy: 0)
        XCTAssertEqual(table.cells.count, 0)
    }
    
    func testTableViewDataLoaded() {
        let table = app.tables.element(boundBy: 0)
        let articleExpectation = expectation(description: "table")
        articleExpectation.fulfill()
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertTrue(table.cells.count > 0)
        }
    }
    
    func testTableViewCellClickAndNavigateBack() {
        app.tables.children(matching: .cell).element(boundBy: 0).staticTexts["ArticleTitle"].tap()
        app.navigationBars["Articles"].buttons["Articles"].tap()
        
        app.tables.children(matching: .cell).element(boundBy: 0).staticTexts["dateLabel"].tap()
        app.navigationBars["Articles"].buttons["Articles"].tap()
    }
}

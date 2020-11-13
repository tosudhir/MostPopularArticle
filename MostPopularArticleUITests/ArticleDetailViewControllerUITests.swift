//
//  ArticleDetailViewControllerUITests.swift
//  MostPopularArticleUITests
//
//  Created by Sudhir Kumar on 13/11/20.
//

import XCTest


class ArticleDetailViewControllerUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        app.launch()
        continueAfterFailure = false
        sleep(3)
    }
    
    func testUILoadedSuccessfully() {
        app.tables.children(matching: .cell).element(boundBy: 0).staticTexts["ArticleTitle"].tap()
        XCTAssertTrue(app.staticTexts["ArticleDetailTitle"].exists)
        XCTAssertTrue(app.staticTexts["DetailByLabel"].exists)
        XCTAssertTrue(app.staticTexts["DetailDateLable"].exists)
        XCTAssertTrue(app.staticTexts["AbstractLabel"].exists)
        app.navigationBars["Articles"].buttons["Articles"].tap()
    }
}

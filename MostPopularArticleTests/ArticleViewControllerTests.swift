//
//  ArticleViewControllerTests.swift
//  MostPopularArticleTests
//
//  Created by Sudhir Kumar on 12/11/20.
//

import XCTest

@testable import MostPopularArticle

class ArticleViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func getMockViewController() -> ArticleViewController? {
        let controller = UIStoryboard(name: "Main", bundle: Bundle(for: ArticleViewController.self)).instantiateViewController(identifier: "ArticleViewController") as? ArticleViewController
        return controller
    }
    
    func testControllerHasTableView() {
        guard let controller = getMockViewController() else {
            return XCTFail("Could not instantiate ViewController from main storyboard")
        }
        controller.loadViewIfNeeded()
        XCTAssertNotNil(controller.articleTableView,
                        "Controller should have a tableview")
    }

}

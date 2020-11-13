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
    
    func testTableViewHasRowAsData() {
        guard let controller = getMockViewController() else {
            return XCTFail("Could not instantiate ViewController from main storyboard")
        }
        controller.loadViewIfNeeded()
        let manager = ApiManager()
        var viewModels: [ArticleViewModel]?
        let articleExpectation = expectation(description: "articles")
        manager.fetchArticles(period: .day) { (article) in
            viewModels = article.map{
             ArticleViewModel(article: $0)
            }
            articleExpectation.fulfill()
        } failure: { (message) in
            print(message)
        }
        waitForExpectations(timeout: 10, handler: nil)
        controller.articleTableView.reloadData()
        let numberOfRow = controller.tableView(controller.articleTableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRow, viewModels?.count ?? 0, "Number of rows in section 0 should match article list.")
    }
    
    func testCellForRow() {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        guard let controller = getMockViewController() else {
            return XCTFail("Could not instantiate ViewController from main storyboard")
        }
        controller.loadViewIfNeeded()
        
        let manager = ApiManager()
        var viewModels: [ArticleViewModel]?
        let articleExpectation = expectation(description: "articles")
        manager.fetchArticles(period: .day) { (article) in
            viewModels = article.map{
             ArticleViewModel(article: $0)
            }
            articleExpectation.fulfill()
        } failure: { (message) in
            print(message)
        }

        waitForExpectations(timeout: 10, handler: nil)
        if let cell = controller.tableView(controller.articleTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ArticleCell {
      
            XCTAssertEqual(cell.articleTitleLabel.text, viewModels?[0].title,
                       "The first cell should display name of article list's first name")
        }
    }
    

}

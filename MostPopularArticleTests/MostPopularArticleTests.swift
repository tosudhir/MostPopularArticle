//
//  MostPopularArticleTests.swift
//  MostPopularArticleTests
//
//  Created by Sudhir Kumar on 12/11/20.
//

import XCTest
@testable import MostPopularArticle

class MostPopularArticleTests: XCTestCase {

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
    
    func testArticleDataFromServerCommunication() throws {
        let manager = ApiManager()
        var articleResponse: [Article]?
        let articleExpectation = expectation(description: "articles")
        manager.fetchArticles(period: .day) { (article) in
            articleResponse = article
            articleExpectation.fulfill()
        } failure: { (message) in
            print(message)
        }
        
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertTrue(articleResponse != nil)
        }
    }
    
    func createMockArticle() -> Article {
        let thumbnail = ArticleMediaMetaData(url: "https://small-image.jpg", format: "Standard Thumbnail")
        let mediumImage = ArticleMediaMetaData(url: "https://small-image.jpg", format: "mediumThreeByTwo210")
        let largeImage = ArticleMediaMetaData(url: "https://large-image.jpg", format: "mediumThreeByTwo440")
        
        let media = ArticleMedia(mediaMetaData: [thumbnail, mediumImage, largeImage])
        
        let article = Article(title: "Biden Wins Presidency", byline: "By Jonathan Martin and Alexander Burns", abstract: "Joseph R. Biden Jr. achieved victory", publishedDate: "2020-11-07", media: [media])
        return article
    }
    
    func testArticleViewModel() {
        let article = createMockArticle()
        let articleViewModel = ArticleViewModel(article: article)
        XCTAssertEqual(article.title, articleViewModel.title)
        XCTAssertEqual(article.byline, articleViewModel.byline)
        XCTAssertEqual(article.publishedDate, articleViewModel.publishedDate)
        XCTAssertEqual(article.abstract, articleViewModel.abstract)
        
        let mediaMetaData = article.media.first?.mediaMetadata
        let thumbnailUrlString = mediaMetaData?.filter{
            $0.format == "Standard Thumbnail"
            }.first?.url
        XCTAssertEqual(thumbnailUrlString, articleViewModel.thumbnailUrlString)
        let imageUrlString = mediaMetaData?.filter{
            $0.format == "mediumThreeByTwo210"
            }.first?.url
        XCTAssertEqual(imageUrlString, articleViewModel.imageUrlString)
        let largeUrlString = mediaMetaData?.filter{
            $0.format == "mediumThreeByTwo440"
            }.first?.url
        XCTAssertEqual(largeUrlString, articleViewModel.largeImageUrlString)
    }

}

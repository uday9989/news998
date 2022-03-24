//
//  NewsinTests.swift
//  NewsinTests
//
//  Created by uday on 21/03/2022.
//

import XCTest
import Combine
@testable import Newsin

class ArticlesViewModelTests: XCTestCase {
    
    var viewModel:ArticleViewModel!
    private var bindings = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        let fakeWebServie = FakeWebServiceManager()
        
        viewModel = ArticleViewModel(fakeWebServie)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetArticles_success() {
        viewModel.getArticles(path:"responce.success", params: [:])
        
        switch viewModel.articleViewState {
        case .loadingArticles :
            print("")
        case .lodingCompleted(let articles) :
            XCTAssertEqual(articles.count, 20)
            XCTAssertEqual(articles[0].title!, "Chinese search for second black box from crashed jet - Reuters.com")
        case .none:
            print("")
        case .error(_):
            print("")
        }
    }
    
    func testGetArticles_failure() {
        viewModel.getArticles(path:"responce.failure", params: [:])
        
        switch viewModel.articleViewState {
        case .loadingArticles :
            print("")
        case .lodingCompleted(let articles) :
            XCTAssertEqual(articles.count, 20)
            XCTAssertEqual(articles[0].title!, "Chinese search for second black box from crashed jet - Reuters.com")
        case .none:
            print("")
        case .error(let error):
            XCTAssertEqual(error, "Failed to load articles , pls try again")
        }
    }

    
}

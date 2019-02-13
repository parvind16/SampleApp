//
//  SampleAppTests.swift
//  SampleAppTests
//
//  Created by parvind bhatt on 12/02/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import XCTest
@testable import SampleApp

class SampleAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testRecipeforExternalId() {
        
        XCHttpStub.request(withPathRegex: "", withResponseFile: "Article-mock.json")
        let responseExpectation = expectation(description: "return expected data of List")
        
        ArticleListVC().getNotificationList { (isSucess, error) in
            
            if isSucess! {
                
                XCTAssertNotNil(isSucess, "list: expected result achived")
                XCTAssertNil(error, "error: Expectation fulfilled with error")
                responseExpectation.fulfill()
            }else{
                
            }
        }
        waitForExpectations(timeout: 50) { error in
            if let error = error {
                XCTAssertNotNil(error, "Failed to get response from list webservice")
            }
        }
    }
}

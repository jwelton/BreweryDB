//
//  RequestBuilderTests.swift
//  BreweryDB
//
//  Created by Jake Welton on 1/30/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import XCTest
@testable import BreweryDB

class RequestBuilderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequestBuilderInitsWithRequestEndPoint() {
        let requestBuilder = RequestBuilder(endPoint: .Beer)
        XCTAssertNotNil(requestBuilder)
    }
    
    func testRequestBuilderNSURLExtensionGivenRawValueReturnsNSURL() {
        let baseURL = NSURL(string: "app.mywebservice.com")
        let url = baseURL?.URLByAppendingPathComponent(.Beer)
        
        XCTAssertEqual(url, NSURL(string: "app.mywebservice.com/beer"))
    }
    
}

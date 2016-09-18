//
//  BreweryDBTests.swift
//  BreweryDBTests
//
//  Created by Jake Welton on 1/3/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import XCTest
@testable import BreweryDB

class BreweryDBTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBreweryDBApiKeyCanBeSet() {
        let apiKey = "My API Key"
        breweryDBApiKey = apiKey
        
        XCTAssertEqual(breweryDBApiKey, apiKey)
    }
    
    func testBreweryDBBaseURLIsNotNil() {
        XCTAssertNotNil(breweryDBBaseURL)
    }
    
}

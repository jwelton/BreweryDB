//
//  BeerJSONParserTests.swift
//  BreweryDB
//
//  Created by Jake Welton on 30/04/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import XCTest
@testable import BreweryDB

class BeerJSONParserTests: XCTestCase {
    var testData: NSData!
    var parser: BeerJSONParser!
    
    override func setUp() {
        super.setUp()
        
        let testFileLocation = NSBundle(forClass: self.dynamicType).URLForResource("testBeerJSON", withExtension: "json")!
        testData = NSData(contentsOfURL: testFileLocation)
        parser = BeerJSONParser(rawData: testData)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBeerJSONParserCanBeInitialized() {
        XCTAssertNotNil(parser)
    }
    
    func testJSOnParserFailsInitializationWithInvalidData() {
        let parser = BeerJSONParser(rawData: "invalid data".dataUsingEncoding(.allZeros)!)
        XCTAssertNil(parser)
    }
    
    func testBeerJSONParserSetsRawData() {
        XCTAssertEqual(parser.rawData, testData)
    }
    
    func testBeerJSONParserExtractsCurrentPage() {
        let expectation = expectationWithDescription("Parser should extract current page")
        
        parser.extractBeersWithCompletionHandler() { beers in
            XCTAssertEqual(self.parser.currentPage, 1)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }
    
    func testBeerJSONParserExtractsTotalPageNumber() {
        let expectation = expectationWithDescription("Parser should extract total number of pages")
        
        parser.extractBeersWithCompletionHandler() { beers in
            XCTAssertEqual(self.parser.totalNumberOfPages, 20)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }
    
    func testBeerJSONParserExtractsTotalResults() {
        let expectation = expectationWithDescription("Parser should extract total results")
        
        parser.extractBeersWithCompletionHandler { beers in
            XCTAssertEqual(self.parser.totalResults, 964)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }
}

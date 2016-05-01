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
    
    func performJSONExtractAndWait(description: String, completionHandler: (([Beer]?)->Void)) {
        let expectation = expectationWithDescription(description)
        
        parser.extractBeersWithCompletionHandler() { beers in
            expectation.fulfill()
            completionHandler(beers)
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }
    
    func testBeerJSONParserCanBeInitialized() {
        XCTAssertNotNil(parser)
    }
    
    func testJSONParserFailsInitializationWithInvalidData() {
        let parser = BeerJSONParser(rawData: "invalid data".dataUsingEncoding(.allZeros)!)
        XCTAssertNil(parser)
    }
    
    func testBeerJSONParserSetsRawData() {
        XCTAssertEqual(parser.rawData, testData)
    }
    
    func testBeerJSONParserExtractsCurrentPage() {
        performJSONExtractAndWait("Parser should extract current page") { beers in
            XCTAssertEqual(self.parser.currentPage, 1)
        }
    }
    
    func testBeerJSONParserExtractsTotalPageNumber() {
        performJSONExtractAndWait("Parser should extract total number of pages") { beers in
            XCTAssertEqual(self.parser.totalNumberOfPages, 20)
        }
    }
    
    func testBeerJSONParserExtractsTotalResults() {
        performJSONExtractAndWait("Parser should extract total results") { beers in
            XCTAssertEqual(self.parser.totalResults, 964)
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerName() {
        performJSONExtractAndWait("Parser should extract first beer page") { beers in
            XCTAssertEqual(beers?[0].name, "'Heifer' Weizen")
        }
    }
}

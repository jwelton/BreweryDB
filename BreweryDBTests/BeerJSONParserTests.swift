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
    var testFileLocation: NSURL!
    var testData: NSData!
    
    override func setUp() {
        super.setUp()
        
        testFileLocation = NSBundle(forClass: self.dynamicType).URLForResource("testBeerJSON", withExtension: "json")
        testData = NSData(contentsOfURL: testFileLocation)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBeerJSONParserCanBeInitialized() {
        let parser = BeerJSONParser(rawData: testData)
        XCTAssertNotNil(parser)
    }
    
    func testJSOnParserFailsInitializationWithInvalidData() {
        let parser = BeerJSONParser(rawData: "invalid data".dataUsingEncoding(.allZeros)!)
        XCTAssertNil(parser)
    }
    
    func testBeerJSONParserSetsRawData() {
        let parser = BeerJSONParser(rawData: testData)
        XCTAssertEqual(parser?.rawData, testData)
    }
    
    func testBeerJSONParserExtractsCurrentPage() {
        let parser = BeerJSONParser(rawData: testData)
        
        let expectation = expectationWithDescription("Parser should extract current page")
        
        parser?.extractBeersWithCompletionHandler() { beers in
            XCTAssertEqual(parser?.currentPage, 1)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }
}

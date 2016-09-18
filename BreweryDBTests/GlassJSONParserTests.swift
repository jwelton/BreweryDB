//
//  GlassJSONParserTests.swift
//  BreweryDB
//
//  Created by Jake Welton on 9/18/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import XCTest
@testable import BreweryDB

class GlassJSONParserTests: XCTestCase {
    var testData: Data!
    var parser: JSONParser<Glass>!
    
    override func setUp() {
        super.setUp()
        
        let testFileLocation = Bundle(for: type(of: self)).url(forResource: "testGlassJSON", withExtension: "json")!
        testData = try? Data(contentsOf: testFileLocation)
        parser = JSONParser<Glass>(rawData: testData)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func performJSONExtractAndWait(_ description: String, completionHandler: @escaping (([Glass]?)->Void)) {
        let expectation = self.expectation(description: description)
        
        parser.extractObjects() { glasses in
            expectation.fulfill()
            completionHandler(glasses)
        }
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
        }
    }
    
    func testGlassJSONParserCanBeInitialized() {
        XCTAssertNotNil(parser)
    }
    
    func testJSONParserFailsInitializationWithInvalidData() {
        let parser = JSONParser<Glass>(rawData: "invalid data".data(using: .utf8)!)
        XCTAssertNil(parser)
    }
    
    func testGlassJSONParserSetsRawData() {
        XCTAssertEqual(parser.rawData, testData)
    }
    
    func testGlassJSONParserExtractsCurrentPage() {
        performJSONExtractAndWait("Parser should extract current page") { glasses in
            XCTAssertEqual(self.parser.currentPage, nil)
        }
    }
    
    func testGlassJSONParserExtractsTotalPageNumber() {
        performJSONExtractAndWait("Parser should extract total number of pages") { glasses in
            XCTAssertEqual(self.parser.totalNumberOfPages, nil)
        }
    }
    
    func testGlassJSONParserExtractsTotalResults() {
        performJSONExtractAndWait("Parser should extract total results") { glasses in
            XCTAssertEqual(self.parser.totalResults, nil)
        }
    }
    
    func testGlassJSONParserExtractsFirstGlassName() {
        performJSONExtractAndWait("Parser should extract first glass name") { glasses in
            XCTAssertEqual(glasses?[0].name, "Flute")
        }
    }
    
    func testGlassJSONParserExtractsFirstGlassIdentifier() {
        performJSONExtractAndWait("Parser should extract first glass name") { glasses in
            XCTAssertEqual(glasses?[0].identifier, 1)
        }
    }
}

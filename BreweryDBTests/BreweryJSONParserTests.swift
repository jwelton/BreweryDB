//
//  BreweryJSONParserTests.swift
//  BreweryDB
//
//  Created by Jake Welton on 02/05/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import XCTest
@testable import BreweryDB

class BreweryJSONParserTests: XCTestCase {
    var testData: NSData!
    var parser: JSONParser<Brewery>!
    
    override func setUp() {
        super.setUp()
        
        let testFileLocation = NSBundle(forClass: self.dynamicType).URLForResource("testBreweryJSON", withExtension: "json")!
        testData = NSData(contentsOfURL: testFileLocation)
        parser = JSONParser<Brewery>(rawData: testData)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func performJSONExtractAndWait(description: String, completionHandler: (([Brewery]?)->Void)) {
        let expectation = expectationWithDescription(description)
        
        parser.extractObjectsWithCompletionHandler() { breweries in
            expectation.fulfill()
            completionHandler(breweries)
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }

}

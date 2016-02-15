//
//  BeerRequestTests.swift
//  BreweryDB
//
//  Created by Jake on 08/01/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import XCTest
@testable import BreweryDB

class BeerRequestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        BreweryDBApiKey = "testKey"
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }
    
    func testBeerCanBeInitialized() {
        let requestParams = [
            BeerRequestParam.Name: "beerName"
        ]
        
        let request: BeerRequest? = BeerRequest(requestParams: requestParams)
        XCTAssertNotNil(request)
    }
 
    func testBeerRequestCanBeDeinitialized() {
        let requestParams = [
            BeerRequestParam.Name: "beerName"
        ]
        
        var request: BeerRequest? = BeerRequest(requestParams: requestParams)
        request = nil
        XCTAssertNil(request)
    }
    
    func testBeerRequestInitWithEmptyParamsReturnsNil() {
        let requestParams:[BeerRequestParam: String] = [:]
        
        var request: BeerRequest? = BeerRequest(requestParams: requestParams)
        request = nil
        XCTAssertNil(request)
    }
    
}

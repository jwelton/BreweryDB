//
//  BreweryRequestTests.swift
//  BreweryDB
//
//  Created by Jake Welton on 29/04/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import XCTest
@testable import BreweryDB

class BreweryRequestTests: XCTestCase {
    let returnData = "Test Data"

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

    func testBreweryCanBeInitialized() {
        let requestParams = [
            BreweryRequestParam.Name: "breweryName"
        ]
        
        let request: BreweryRequest? = BreweryRequest(requestParams: requestParams)
        XCTAssertNotNil(request)
    }
    
    func testBreweryRequestCanBeDeinitialized() {
        let requestParams = [
            BreweryRequestParam.Name: "breweryName"
        ]
        
        var request: BreweryRequest? = BreweryRequest(requestParams: requestParams)
        request = nil
        XCTAssertNil(request)
    }
    
    func testBreweryRequestInitWithEmptyParamsReturnsNil() {
        let requestParams:[BreweryRequestParam: String] = [:]
        
        var request: BreweryRequest? = BreweryRequest(requestParams: requestParams)
        request = nil
        XCTAssertNil(request)
    }
    
    func testBreweryRequestLoadBeersWithBreweryIdReturnsSuccessful() {
        stub(isHost("api.brewerydb.com")) { _ in
            let stubData = self.returnData.dataUsingEncoding(NSUTF8StringEncoding)
            return OHHTTPStubsResponse(data: stubData!, statusCode:200, headers:nil)
        }
        
        let expectation = expectationWithDescription("URL request should return within 5 seconds")
        let requestParams = [ BreweryRequestParam.Identifier: "NTrt0Z" ]
        
        guard let request = BreweryRequest(requestParams: requestParams) else {
            XCTFail("Brewery request initialisation should not fail")
            return
        }
        
        request.loadBreweriesWithCompletionHandler() { breweries in
            XCTAssertEqual(breweries![0].identifier, self.returnData)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }
    
    func testBreweryRequestLoadBreweriesWithNilAPIKeyReturnsNil() {
        let expectation = expectationWithDescription("Breweries should return nil")
        let requestParams = [ BreweryRequestParam.Identifier: "NTrt0Z" ]
        
        BreweryDBApiKey = nil
        
        guard let request = BreweryRequest(requestParams: requestParams) else {
            XCTFail("Brewery request initialisation should not fail")
            return
        }
        
        request.loadBreweriesWithCompletionHandler { breweries in
            XCTAssertNil(breweries)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }
    
    func testBreweriesRequestLoadBreweriesWithNoConnectionReturnsNil() {
        stub(isHost("api.brewerydb.com")) { _ in
            let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.CFURLErrorNotConnectedToInternet.rawValue), userInfo:nil)
            return OHHTTPStubsResponse(error:notConnectedError)
        }
        
        let expectation = expectationWithDescription("URL request should return within 5 seconds")
        let requestParams = [ BreweryRequestParam.Identifier: "NTrt0Z" ]
        
        guard let request = BreweryRequest(requestParams: requestParams) else {
            XCTFail("Brewery request initialisation should not fail")
            return
        }
        
        request.loadBreweriesWithCompletionHandler() { breweries in
            XCTAssertNil(breweries)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }

}

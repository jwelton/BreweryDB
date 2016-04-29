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
    
    func testBeerRequestLoadBeersWithBeerIdReturnsSuccessful() {
        stub(isHost("api.brewerydb.com")) { _ in
            let stubData = self.returnData.dataUsingEncoding(NSUTF8StringEncoding)
            return OHHTTPStubsResponse(data: stubData!, statusCode:200, headers:nil)
        }
        
        let expectation = expectationWithDescription("URL request should return within 5 seconds")
        let requestParams = [ BeerRequestParam.Identifier: "NTrt0Z" ]
        
        guard let request = BeerRequest(requestParams: requestParams) else {
            XCTFail("Beer request initialisation should not fail")
            return
        }
        
        request.loadBeersWithCompletionHandler() { beers in
            XCTAssertEqual(beers![0].identifier, self.returnData)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }
    
    func testBeerRequestLoadBeersWithNilAPIKeyReturnsNil() {
        let expectation = expectationWithDescription("Beers should return nil")
        let requestParams = [ BeerRequestParam.Identifier: "NTrt0Z" ]
        
        BreweryDBApiKey = nil
        
        guard let request = BeerRequest(requestParams: requestParams) else {
            XCTFail("Beer request initialisation should not fail")
            return
        }
        
        request.loadBeersWithCompletionHandler { beers in
            XCTAssertNil(beers)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }
    
    func testBeerRequestLoadBeersWithNoConnectionReturnsNil() {
        stub(isHost("api.brewerydb.com")) { _ in
            let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.CFURLErrorNotConnectedToInternet.rawValue), userInfo:nil)
            return OHHTTPStubsResponse(error:notConnectedError)
        }
        
        let expectation = expectationWithDescription("URL request should return within 5 seconds")
        let requestParams = [ BeerRequestParam.Identifier: "NTrt0Z" ]
        
        guard let request = BeerRequest(requestParams: requestParams) else {
            XCTFail("Beer request initialisation should not fail")
            return
        }
        
        request.loadBeersWithCompletionHandler() { beers in
            XCTAssertNil(beers)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }
    
}

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
    var testFileLocation: NSURL!

    override func setUp() {
        super.setUp()
        
        BreweryDBApiKey = "testKey"
        testFileLocation = NSBundle(forClass: self.dynamicType).URLForResource("testBreweryJSON", withExtension: "json")!
        
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
    
    func testBreweryRequestLoadBreweryWithBreweryIdReturnsSuccessful() {
        stub(isHost("api.brewerydb.com")) { _ in
            return OHHTTPStubsResponse(fileAtPath: self.testFileLocation.path!, statusCode: 200, headers: nil)
        }
        
        let expectation = expectationWithDescription("URL request should return within 5 seconds")
        let requestParams = [ BreweryRequestParam.Identifier: "NTrt0Z" ]
        
        guard let request = BreweryRequest(requestParams: requestParams) else {
            XCTFail("Brewery request initialisation should not fail")
            return
        }
        
        request.loadBreweriesWithCompletionHandler() { breweries in
            XCTAssertEqual(breweries![0].identifier, "sPZjl6")
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }
    
    func testBreweryRequestLoadBreweriesWithNilAPIKeyReturnsNil() {
        let requestParams = [ BreweryRequestParam.Identifier: "NTrt0Z" ]
        
        BreweryDBApiKey = nil
        
        let request = BreweryRequest(requestParams: requestParams)
        
        XCTAssertNil(request)
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
    
    func testBreweryRequestLoadNextPageIncrementsPageNumber() {
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
        
        XCTAssertEqual(request.currentPageNumber, 0)
        
        request.loadNextPageWithCompletionHandler { _ in
            XCTAssertEqual(request.currentPageNumber, 1)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }
    
    func testBreweryRequestLoadNextPageAttachesPageNumberToURL() {
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
        
        XCTAssertEqual(request.currentPageNumber, 0)
        
        request.loadNextPageWithCompletionHandler { _ in
            XCTAssertEqual(request.requestURL.URL?.absoluteString, "\(BreweryDBBaseURL)/breweries?key=\(BreweryDBApiKey!)&ids=\(requestParams[.Identifier]!)&p=1")
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }

}

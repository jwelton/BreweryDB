//
//  RequestManagerTests.swift
//  BreweryDB
//
//  Created by Jake Welton on 2016-07-21.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation
import XCTest

@testable import BreweryDB

class RequestManagerTests: XCTestCase {
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
    
    func testRequestManagerCanBeInitialized() {
        let requestParams = [
            BreweryRequestParam.Name: "breweryName"
        ]
        
        let manager: RequestManager? = RequestManager<Brewery>(request: BreweryRequest(params: requestParams, orderBy: nil))
        XCTAssertNotNil(manager)
    }
    
    func testRequestManagerRequestCanBeDeinitialized() {
        let requestParams = [
            BreweryRequestParam.Name: "breweryName"
        ]
        
        var manager: RequestManager? = RequestManager<Brewery>(request: BreweryRequest(params: requestParams, orderBy: nil))
        manager = nil
        XCTAssertNil(manager)
    }

    func testRequestManagerRequestLoadBreweryWithBreweryIdReturnsSuccessful() {
        stub(isHost("api.brewerydb.com")) { _ in
            return OHHTTPStubsResponse(fileAtPath: self.testFileLocation.path!, statusCode: 200, headers: nil)
        }
        
        let expectation = expectationWithDescription("URL request should return within 5 seconds")
        let requestParams = [ BreweryRequestParam.Identifier: "NTrt0Z" ]
        
        guard let manager = RequestManager<Brewery>(request: BreweryRequest(params: requestParams, orderBy: nil)) else {
            XCTFail("Brewery request initialisation should not fail")
            return
        }
        
        manager.loadWithCompletionHandler() { breweries in
            XCTAssertEqual(breweries![0].identifier, "sPZjl6")
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }

    func testRequestManagerRequestLoadBreweriesWithNilAPIKeyReturnsNil() {
        let requestParams = [ BreweryRequestParam.Identifier: "NTrt0Z" ]
        
        BreweryDBApiKey = nil
        
        let manager = RequestManager<Brewery>(request: BreweryRequest(params: requestParams, orderBy: nil))
        
        XCTAssertNil(manager)
    }

    func testBreweriesRequestLoadBreweriesWithNoConnectionReturnsNil() {
        stub(isHost("api.brewerydb.com")) { _ in
            let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.CFURLErrorNotConnectedToInternet.rawValue), userInfo:nil)
            return OHHTTPStubsResponse(error:notConnectedError)
        }
        
        let expectation = expectationWithDescription("URL request should return within 5 seconds")
        let requestParams = [ BreweryRequestParam.Identifier: "NTrt0Z" ]
        
        guard let manager = RequestManager<Brewery>(request: BreweryRequest(params: requestParams, orderBy: nil)) else {
            XCTFail("Brewery request initialisation should not fail")
            return
        }
        
        manager.loadWithCompletionHandler() { breweries in
            XCTAssertNil(breweries)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }

    func testRequestManagerRequestLoadNextPageIncrementsPageNumber() {
        stub(isHost("api.brewerydb.com")) { _ in
            let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.CFURLErrorNotConnectedToInternet.rawValue), userInfo:nil)
            return OHHTTPStubsResponse(error:notConnectedError)
        }
        
        let expectation = expectationWithDescription("URL request should return within 5 seconds")
        let requestParams = [ BreweryRequestParam.Identifier: "NTrt0Z" ]
        
        guard let manager = RequestManager<Brewery>(request: BreweryRequest(params: requestParams, orderBy: nil)) else {
            XCTFail("Brewery request initialisation should not fail")
            return
        }
        
        XCTAssertEqual(manager.currentPageNumber, 0)
        
        manager.loadNextPageWithCompletionHandler { _ in
            XCTAssertEqual(manager.currentPageNumber, 1)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }

    func testRequestManagerRequestLoadNextPageAttachesPageNumberToURL() {
        stub(isHost("api.brewerydb.com")) { _ in
            let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.CFURLErrorNotConnectedToInternet.rawValue), userInfo:nil)
            return OHHTTPStubsResponse(error:notConnectedError)
        }
        
        let expectation = expectationWithDescription("URL request should return within 5 seconds")
        let requestParams = [ BreweryRequestParam.Identifier: "NTrt0Z" ]
        
        guard let manager = RequestManager<Brewery>(request: BreweryRequest(params: requestParams, orderBy: nil)) else {
            XCTFail("Brewery request initialisation should not fail")
            return
        }
        
        XCTAssertEqual(manager.currentPageNumber, 0)
        
        manager.loadNextPageWithCompletionHandler { _ in
            let components = NSURLComponents(URL: manager.requestURL.URL!, resolvingAgainstBaseURL: false)
            let doesParamExist = components?.queryItems?.contains{ $0.name == "p" && $0.value == "1" }
            XCTAssertTrue(doesParamExist!)
            
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }

    func testRequestManagerRequestAttachesOrderToURL() {
        stub(isHost("api.brewerydb.com")) { _ in
            let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.CFURLErrorNotConnectedToInternet.rawValue), userInfo:nil)
            return OHHTTPStubsResponse(error:notConnectedError)
        }
        
        let expectation = expectationWithDescription("URL request should return within 5 seconds")
        let requestParams = [ BreweryRequestParam.Identifier: "NTrt0Z" ]
        
        guard let manager = RequestManager<Brewery>(request: BreweryRequest(params: requestParams, orderBy: .Name)) else {
            XCTFail("Brewery request initialisation should not fail")
            return
        }
        
        manager.loadNextPageWithCompletionHandler { _ in
            let components = NSURLComponents(URL: manager.requestURL.URL!, resolvingAgainstBaseURL: false)
            let doesParamExist = components?.queryItems?.contains{ $0.name == "order" && $0.value == "name" }
            XCTAssertTrue(doesParamExist!)
            
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }
    
}

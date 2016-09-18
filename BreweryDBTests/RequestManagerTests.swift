//
//  RequestManagerTests.swift
//  BreweryDB
//
//  Created by Jake Welton on 2016-07-21.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation
import XCTest
import OHHTTPStubs

@testable import BreweryDB

class RequestManagerTests: XCTestCase {
    let returnData = "Test Data"
    var testFileLocation: URL!
    
    override func setUp() {
        super.setUp()
        
        breweryDBApiKey = "testKey"
        testFileLocation = Bundle(for: type(of: self)).url(forResource: "testBreweryJSON", withExtension: "json")!
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }
    
    func testRequestManagerCanBeInitialized() {
        let requestParams = [
            BreweryRequestParam.name: "breweryName"
        ]
        
        let manager: RequestManager? = RequestManager<Brewery>(request: BreweryRequest(params: requestParams, orderBy: nil))
        XCTAssertNotNil(manager)
    }
    
    func testRequestManagerRequestCanBeDeinitialized() {
        let requestParams = [
            BreweryRequestParam.name: "breweryName"
        ]
        
        var manager: RequestManager? = RequestManager<Brewery>(request: BreweryRequest(params: requestParams, orderBy: nil))
        manager = nil
        XCTAssertNil(manager)
    }

    func testRequestManagerRequestLoadBreweryWithBreweryIdReturnsSuccessful() {
        let _ = stub(condition: isHost("api.brewerydb.com")) { _ in
            return OHHTTPStubsResponse(fileAtPath: self.testFileLocation.path, statusCode: 200, headers: nil)
        }
        
        let expectation = self.expectation(description: "URL request should return within 5 seconds")
        let requestParams = [ BreweryRequestParam.identifier: "NTrt0Z" ]
        
        guard let manager = RequestManager<Brewery>(request: BreweryRequest(params: requestParams, orderBy: nil)) else {
            XCTFail("Brewery request initialisation should not fail")
            return
        }
        
        manager.fetch() { breweries in
            XCTAssertEqual(breweries![0].identifier, "sPZjl6")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
        }
    }

    func testRequestManagerRequestLoadBreweriesWithNilAPIKeyReturnsNil() {
        let requestParams = [ BreweryRequestParam.identifier: "NTrt0Z" ]
        
        breweryDBApiKey = nil
        
        let manager = RequestManager<Brewery>(request: BreweryRequest(params: requestParams, orderBy: nil))
        
        XCTAssertNil(manager)
    }

    func testBreweriesRequestLoadBreweriesWithNoConnectionReturnsNil() {
        let _ = stub(condition: isHost("api.brewerydb.com")) { _ in
            let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue), userInfo:nil)
            return OHHTTPStubsResponse(error:notConnectedError)
        }
        
        let expectation = self.expectation(description: "URL request should return within 5 seconds")
        let requestParams = [ BreweryRequestParam.identifier: "NTrt0Z" ]
        
        guard let manager = RequestManager<Brewery>(request: BreweryRequest(params: requestParams, orderBy: nil)) else {
            XCTFail("Brewery request initialisation should not fail")
            return
        }
        
        manager.fetch() { breweries in
            XCTAssertNil(breweries)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
        }
    }

    func testRequestManagerRequestLoadNextPageIncrementsPageNumber() {
        let _ = stub(condition: isHost("api.brewerydb.com")) { _ in
            let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue), userInfo:nil)
            return OHHTTPStubsResponse(error:notConnectedError)
        }
        
        let expectation = self.expectation(description: "URL request should return within 5 seconds")
        let requestParams = [ BreweryRequestParam.identifier: "NTrt0Z" ]
        
        guard let manager = RequestManager<Brewery>(request: BreweryRequest(params: requestParams, orderBy: nil)) else {
            XCTFail("Brewery request initialisation should not fail")
            return
        }
        
        XCTAssertEqual(manager.currentPageNumber, 0)
        
        manager.fetchNextPage { _ in
            XCTAssertEqual(manager.currentPageNumber, 1)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
        }
    }

    func testRequestManagerRequestLoadNextPageAttachesPageNumberToURL() {
        let _ = stub(condition: isHost("api.brewerydb.com")) { _ in
            let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue), userInfo:nil)
            return OHHTTPStubsResponse(error:notConnectedError)
        }
        
        let expectation = self.expectation(description: "URL request should return within 5 seconds")
        let requestParams = [ BreweryRequestParam.identifier: "NTrt0Z" ]
        
        guard let manager = RequestManager<Brewery>(request: BreweryRequest(params: requestParams, orderBy: nil)) else {
            XCTFail("Brewery request initialisation should not fail")
            return
        }
        
        XCTAssertEqual(manager.currentPageNumber, 0)
        
        manager.fetchNextPage { _ in
            let components = NSURLComponents(url: manager.requestURL.url!, resolvingAgainstBaseURL: false)
            let doesParamExist = components?.queryItems?.contains{ $0.name == "p" && $0.value == "1" }
            XCTAssertTrue(doesParamExist!)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
        }
    }

    func testRequestManagerRequestAttachesOrderToURL() {
        let _ = stub(condition: isHost("api.brewerydb.com")) { _ in
            let notConnectedError = NSError(domain:NSURLErrorDomain, code:Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue), userInfo:nil)
            return OHHTTPStubsResponse(error:notConnectedError)
        }
        
        let expectation = self.expectation(description: "URL request should return within 5 seconds")
        let requestParams = [ BreweryRequestParam.identifier: "NTrt0Z" ]
        
        guard let manager = RequestManager<Brewery>(request: BreweryRequest(params: requestParams, orderBy: .name)) else {
            XCTFail("Brewery request initialisation should not fail")
            return
        }
        
        manager.fetchNextPage { _ in
            let components = NSURLComponents(url: manager.requestURL.url!, resolvingAgainstBaseURL: false)
            let doesParamExist = components?.queryItems?.contains{ $0.name == "order" && $0.value == "name" }
            XCTAssertTrue(doesParamExist!)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
        }
    }
    
}

//
//  RequestBuilderTests.swift
//  BreweryDB
//
//  Created by Jake Welton on 1/30/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import XCTest
@testable import BreweryDB

class RequestBuilderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        BreweryDBApiKey = "testKey"
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequestBuilderInitsWithRequestEndPoint() {
        let requestBuilder = RequestBuilder(endPoint: .Beers)
        XCTAssertNotNil(requestBuilder)
    }
    
    func testRequestBuilderNSURLExtensionGivenRawValueReturnsNSURL() {
        let baseURL = NSURL(string: "app.mywebservice.com")
        let url = baseURL?.URLByAppendingPathComponent(.Beers)
        
        XCTAssertEqual(url, NSURL(string: "app.mywebservice.com/beers"))
    }
    
    func testRequestBuilderWith1ParamBuildsRequest() {
        let requestBuilder = RequestBuilder(endPoint: .Beers)
        let param = [BeerRequestParam.Identifier: "beerIdentifier"]
        
        let baseURL = BreweryDBBaseURL.absoluteString + "/" + RequestEndPoint.Beers.rawValue
        let withKey = baseURL + "?key=" + String(BreweryDBApiKey!)
        let expected =  withKey + "&" + BeerRequestParam.Identifier.rawValue + "=beerIdentifier"
        
        let url = requestBuilder.buildRequest(BeerRequest(params: param, orderBy: nil))
        url?.URL?.absoluteString
        
        XCTAssertEqual(url?.URL?.absoluteString, expected)
    }
    
    func testRequestBuilderWith2ParamsBuildsRequest() {
        let requestBuilder = RequestBuilder(endPoint: .Beers)
        let param = [BeerRequestParam.Identifier: "beerIdentifier", BeerRequestParam.Name: "beerName"]
        
        let baseURL = BreweryDBBaseURL.absoluteString + "/" + RequestEndPoint.Beers.rawValue
        let withKey = baseURL + "?key=" + String(BreweryDBApiKey!)
        let urlWithFirstParam =  withKey + "&" + BeerRequestParam.Identifier.rawValue + "=" + param[.Identifier]!
        let expected =  urlWithFirstParam + "&" + BeerRequestParam.Name.rawValue + "=" + param[.Name]!
        
        let url = requestBuilder.buildRequest(BeerRequest(params: param, orderBy: nil))
        
        XCTAssertEqual(url?.URL?.absoluteString, expected)
    }
    
    func testRequestBuilderWithNoAPIKeyReturnNil() {
        let requestBuilder = RequestBuilder(endPoint: .Beers)
        let param = [BeerRequestParam.Identifier: "beerIdentifier", BeerRequestParam.Name: "beerName"]
        BreweryDBApiKey = nil
        
        let url = requestBuilder.buildRequest(BeerRequest(params: param, orderBy: nil))
        
        XCTAssertNil(url)
    }
    
}

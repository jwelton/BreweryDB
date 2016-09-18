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
        
        breweryDBApiKey = "testKey"
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequestBuilderInitsWithRequestEndPoint() {
        let requestBuilder = RequestBuilder(endPoint: .beers)
        XCTAssertNotNil(requestBuilder)
    }
    
    func testRequestBuilderNSURLExtensionGivenRawValueReturnsNSURL() {
        let baseURL = URL(string: "app.mywebservice.com")
        let url = baseURL?.appendingPathComponent(.beers)
        
        XCTAssertEqual(url, URL(string: "app.mywebservice.com/beers"))
    }
    
    func testRequestBuilderWith1ParamBuildsRequest() {
        let requestBuilder = RequestBuilder(endPoint: .beers)
        let param = [BeerRequestParam.identifier: "beerIdentifier"]
        
        let baseURL = breweryDBBaseURL.absoluteString + "/" + RequestEndPoint.beers.rawValue
        let withKey = baseURL + "?key=" + String(breweryDBApiKey!)
        let expected =  withKey + "&" + BeerRequestParam.identifier.rawValue + "=beerIdentifier"
        
        let url = requestBuilder.buildRequest(BeerRequest(params: param, orderBy: nil))
        
        XCTAssertEqual(url?.url?.absoluteString, expected)
    }
    
    func testRequestBuilderWith2ParamsBuildsRequest() {
        let requestBuilder = RequestBuilder(endPoint: .beers)
        let param = [BeerRequestParam.identifier: "beerIdentifier", BeerRequestParam.name: "beerName"]
        
        let url = requestBuilder.buildRequest(BeerRequest(params: param, orderBy: nil))
        
        let components = URLComponents(url: url!.url!, resolvingAgainstBaseURL: false)
        XCTAssertTrue(components!.queryItems!.contains(URLQueryItem(name: "ids", value: "beerIdentifier")))
        XCTAssertTrue(components!.queryItems!.contains(URLQueryItem(name: "name", value: "beerName")))
    }
    
    func testRequestBuilderWithNoAPIKeyReturnNil() {
        let requestBuilder = RequestBuilder(endPoint: .beers)
        let param = [BeerRequestParam.identifier: "beerIdentifier", BeerRequestParam.name: "beerName"]
        breweryDBApiKey = nil
        
        let url = requestBuilder.buildRequest(BeerRequest(params: param, orderBy: nil))
        
        XCTAssertNil(url)
    }
    
}

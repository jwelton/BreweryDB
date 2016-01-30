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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequestBuilderInitsWithRequestEndPoint() {
        let requestBuilder = RequestBuilder(endPoint: .Beer)
        XCTAssertNotNil(requestBuilder)
    }
    
    func testRequestBuilderNSURLExtensionGivenRawValueReturnsNSURL() {
        let baseURL = NSURL(string: "app.mywebservice.com")
        let url = baseURL?.URLByAppendingPathComponent(.Beer)
        
        XCTAssertEqual(url, NSURL(string: "app.mywebservice.com/beer"))
    }
    
    func testRequestBuilderNSURLExtensionGivenOneGETVarReturnsNSURL() {
        let baseURL = NSURL(string: "app.mywebservice.com")
        let url = baseURL?.URLByAppendingGETVariable(BeerRequestParam.Identifier, value: "ID", isFirstVar: true)
        
        XCTAssertEqual(url, NSURL(string: "app.mywebservice.com?ids=ID"))
    }
    
    func testRequestBuilderNSURLExtensionGivenTwoGETVarReturnsNSURL() {
        let baseURL = NSURL(string: "app.mywebservice.com")
        let urlWithFirst = baseURL?.URLByAppendingGETVariable(BeerRequestParam.Identifier, value: "ID", isFirstVar: true)
        let url = urlWithFirst?.URLByAppendingGETVariable(BeerRequestParam.Name, value: "beer", isFirstVar: false)
        
        XCTAssertEqual(url, NSURL(string: "app.mywebservice.com?ids=ID&name=beer"))
    }
    
    func testRequestBuilderWith1ParamBuildsRequest() {
        let requestBuilder = RequestBuilder(endPoint: .Beer)
        let param = [BeerRequestParam.Identifier: "beerIdentifier"]
        
        let baseURL = BreweryDBBaseURL.absoluteString + "/" + RequestEndPoint.Beer.rawValue
        let expected =  baseURL + "?" + BeerRequestParam.Identifier.rawValue + "=beerIdentifier"
        
        let url = requestBuilder.buildRequest(param)
        
        XCTAssertEqual(url.absoluteString, expected)
    }
    
    func testRequestBuilderWith2ParamsBuildsRequest() {
        let requestBuilder = RequestBuilder(endPoint: .Beer)
        let param = [BeerRequestParam.Identifier: "beerIdentifier", BeerRequestParam.Name: "beerName"]
        
        let baseURL = BreweryDBBaseURL.absoluteString + "/" + RequestEndPoint.Beer.rawValue
        let urlWithFirstParam =  baseURL + "?" + BeerRequestParam.Identifier.rawValue + "=" + param[.Identifier]!
        let expected =  urlWithFirstParam + "&" + BeerRequestParam.Name.rawValue + "=" + param[.Name]!
        
        let url = requestBuilder.buildRequest(param)
        
        XCTAssertEqual(url.absoluteString, expected)
    }
    
}

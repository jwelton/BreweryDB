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
    func testBreweryCanBeInitialized() {
        let requestParams = [
            BreweryRequestParam.Name: "breweryName"
        ]
        
        let request: BreweryRequest? = BreweryRequest(params: requestParams, orderBy: .Name)
        XCTAssertNotNil(request)
    }
    
    func testBreweryRequestCanBeDeinitialized() {
        let requestParams = [
            BreweryRequestParam.Name: "breweryName"
        ]
        
        var request: BreweryRequest? = BreweryRequest(params: requestParams, orderBy: .Name)
        request = nil
        XCTAssertNil(request)
    }
    
    func testBreweryRequestInitWithEmptyParams() {
        let request: BreweryRequest? = BreweryRequest(params: nil, orderBy: nil)
        XCTAssertNotNil(request)
    }
}

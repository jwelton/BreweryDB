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
            BreweryRequestParam.name: "breweryName"
        ]
        
        let request: BreweryRequest? = BreweryRequest(params: requestParams, orderBy: .name)
        XCTAssertNotNil(request)
    }
    
    func testBreweryRequestCanBeDeinitialized() {
        let requestParams = [
            BreweryRequestParam.name: "breweryName"
        ]
        
        var request: BreweryRequest? = BreweryRequest(params: requestParams, orderBy: .name)
        request = nil
        XCTAssertNil(request)
    }
    
    func testBreweryRequestInitWithEmptyParams() {
        let request: BreweryRequest? = BreweryRequest(params: nil, orderBy: nil)
        XCTAssertNotNil(request)
    }
}

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
    func testBeerCanBeInitialized() {
        let requestParams = [
            BeerRequestParam.Name: "beerName"
        ]
        
        let request: BeerRequest? = BeerRequest(params: requestParams, orderBy: .Name)
        XCTAssertNotNil(request)
    }
 
    func testBeerRequestCanBeDeinitialized() {
        let requestParams = [
            BeerRequestParam.Name: "beerName"
        ]
        
        var request: BeerRequest? = BeerRequest(params: requestParams, orderBy: .Name)
        request = nil
        XCTAssertNil(request)
    }
    
    func testBeerRequestInitWithEmptyParams() {
        let request: BeerRequest? = BeerRequest(params: nil, orderBy: nil)
        XCTAssertNotNil(request)
    }
}

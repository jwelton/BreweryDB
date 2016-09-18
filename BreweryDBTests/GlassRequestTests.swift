//
//  GlassRequestTests.swift
//  BreweryDB
//
//  Created by Jake Welton on 9/18/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import XCTest
@testable import BreweryDB

class GlassRequestTests: XCTestCase {
    
    func testGlassCanBeInitialized() {
        let requestParams = [
            GlassRequestParam.pageNumber: "0"
        ]
        
        let request: GlassRequest? = GlassRequest(params: requestParams)
        XCTAssertNotNil(request)
    }
    
    func testGlassRequestCanBeDeinitialized() {
        let requestParams = [
            GlassRequestParam.pageNumber: "0"
        ]
        
        var request: GlassRequest? = GlassRequest(params: requestParams)
        request = nil
        XCTAssertNil(request)
    }
    
    func testGlassRequestInitWithEmptyParams() {
        let request: GlassRequest? = GlassRequest(params: nil)
        XCTAssertNotNil(request)
    }
    
}

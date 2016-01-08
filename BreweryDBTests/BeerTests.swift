//
//  BeerTests.swift
//  BreweryDB
//
//  Created by Jake Welton on 1/3/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import XCTest
@testable import BreweryDB

class BeerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBeerCanBeInitialized() {
        let beer: Beer? = Beer()
        XCTAssertNotNil(beer)
    }
    
    func testBeerCanBeDeinitialized() {
        var beer: Beer? = Beer()
        beer = nil
        XCTAssertNil(beer)
    }
    
}

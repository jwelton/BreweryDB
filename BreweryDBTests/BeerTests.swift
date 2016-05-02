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
    
    func testBeerCanBeInitializedWithIdentifier() {
        let beer: Beer? = Beer(identifier: "Beer identifier")

        XCTAssertNotNil(beer)
    }
    
    func testBeerCanBeDeinitialized() {
        var beer: Beer? = Beer(identifier: "Beer Identifier")
        beer = nil
        XCTAssertNil(beer)
    }
    
    func testBeerCanSetIdentifier() {
        let testData = "TestData"
        
        let beer = Beer(identifier: testData)
        XCTAssertEqual(testData, beer.identifier)
    }
    
    func testBeerCanSetName() {
        let testData = "TestData"
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.name = testData
        XCTAssertEqual(testData, beer.name)
    }
    
    func testBeerCanSetDescription() {
        let testData = "TestData"
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.beerDescription = testData
        XCTAssertEqual(testData, beer.beerDescription)
    }
    
    func testBeerCanSetOriginalGravity() {
        let testData = "TestData"
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.originalGravity = testData
        XCTAssertEqual(testData, beer.originalGravity)
    }
    
    func testBeerCanSetAbv() {
        let testData = "TestData"
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.abv = testData
        XCTAssertEqual(testData, beer.abv)
    }
    
    func testBeerCanSetIbu() {
        let testData = "TestData"
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.ibu = testData
        XCTAssertEqual(testData, beer.ibu)
    }
    
    func testBeerCanSetisOrganic() {
        let testData = true
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.isOrganic = testData
        XCTAssertEqual(testData, beer.isOrganic)
    }
    
    func testBeerCanSetServingTemperature() {
        let testData = "TestData"
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.servingTemperature = testData
        XCTAssertEqual(testData, beer.servingTemperature)
    }
    
    func testBeerCanSetServingTemperatureDisplay() {
        let testData = "TestData"
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.servingTemperatureDisplay = testData
        XCTAssertEqual(testData, beer.servingTemperatureDisplay)
    }
    
    func testBeerCanSetStatus() {
        let testData = "TestData"
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.status = testData
        XCTAssertEqual(testData, beer.status)
    }
    
    func testBeerCanSetStatusDisplay() {
        let testData = "TestData"
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.statusDisplay = testData
        XCTAssertEqual(testData, beer.statusDisplay)
    }
}

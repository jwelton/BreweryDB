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
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.identifier = testData
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
        beer.description = testData
        XCTAssertEqual(testData, beer.description)
    }
    
    func testBeerCanSetFoodPairings() {
        let testData = "TestData"
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.foodPairings = testData
        XCTAssertEqual(testData, beer.foodPairings)
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
    
    func testBeerCanSetGlasswareId() {
        let testData = "TestData"
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.glasswareId = testData
        XCTAssertEqual(testData, beer.glasswareId)
    }
    
    func testBeerCanSetGlass() {
        let testData = "TestData"
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.glass = testData
        XCTAssertEqual(testData, beer.glass)
    }
    
    func testBeerCanSetStyleId() {
        let testData = "TestData"
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.styleId = testData
        XCTAssertEqual(testData, beer.styleId)
    }
    
    func testBeerCanSetStyle() {
        let testData = "TestData"
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.style = testData
        XCTAssertEqual(testData, beer.style)
    }
    
    func testBeerCanSetisOrganic() {
        let testData = true
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.isOrganic = testData
        XCTAssertEqual(testData, beer.isOrganic)
    }
    
    func testBeerCanSetLabels() {
        let testData = "TestData"
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.labels = testData
        XCTAssertEqual(testData, beer.labels)
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
    
    func testBeerCanSetAvailableId() {
        let testData = "TestData"
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.availableId = testData
        XCTAssertEqual(testData, beer.availableId)
    }
    
    func testBeerCanSetAvailable() {
        let testData = "TestData"
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.available = testData
        XCTAssertEqual(testData, beer.available)
    }
    
    func testBeerCanSetBeerVariation() {
        let testData = "TestData"
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.beerVariation = testData
        XCTAssertEqual(testData, beer.beerVariation)
    }
    
    func testBeerCanSetYear() {
        let testData = "TestData"
        
        let beer = Beer(identifier: "Beer Identifier")
        beer.year = testData
        XCTAssertEqual(testData, beer.year)
    }
}

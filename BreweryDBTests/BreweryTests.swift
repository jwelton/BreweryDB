//
//  BreweryTests.swift
//  BreweryDB
//
//  Created by Jake Welton on 29/04/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import XCTest
@testable import BreweryDB

class BreweryTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBreweryCanBeInitializedWithIdentifier() {
        let brewery: Brewery? = Brewery(identifier: "Brewery identifier")
        
        XCTAssertNotNil(brewery)
    }
    
    func testBeerCanSetIdentifier() {
        let testData = "TestData"
        
        let brewery = Brewery(identifier: testData)
        XCTAssertEqual(testData, brewery.identifier)
    }
    
    func testBeerCanSetName() {
        let testData = "TestData"
        
        let brewery = Brewery(identifier: "Brewery identifier")
        brewery.name = testData
        XCTAssertEqual(testData, brewery.name)
    }
    
    func testBeerCanSetEstablished() {
        let testData = 1993
        
        let brewery = Brewery(identifier: "Brewery identifier")
        brewery.established = testData
        XCTAssertEqual(testData, brewery.established)
    }
    
    func testBeerCanSetIsOrganic() {
        let testData = true
        
        let brewery = Brewery(identifier: "Brewery identifier")
        brewery.isOrganic = testData
        XCTAssertEqual(testData, brewery.isOrganic)
    }
    
    func testBeerCanSetDescription() {
        let testData = "TestData"
        
        let brewery = Brewery(identifier: "Brewery identifier")
        brewery.breweryDescription = testData
        XCTAssertEqual(testData, brewery.breweryDescription)
    }
    
    func testBeerCanSetWebsite() {
        let testData = NSURL(string: "http://www.brewerydb.com")
        
        let brewery = Brewery(identifier: "Brewery identifier")
        brewery.website = testData
        XCTAssertEqual(testData, brewery.website)
    }
    
    func testBeerCanSetmailingListURL() {
        let testData = NSURL(string: "http://www.brewerydb.com")
        
        let brewery = Brewery(identifier: "Brewery identifier")
        brewery.mailingListURL = testData
        XCTAssertEqual(testData, brewery.mailingListURL)
    }
}

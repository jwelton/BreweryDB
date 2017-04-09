//
//  IngredientJSONParserTests.swift
//  BreweryDB
//
//  Created by Jake Welton on 4/8/17.
//  Copyright © 2017 Jake Welton. All rights reserved.
//

import XCTest
@testable import BreweryDB

class IngredientJSONParserTests: XCTestCase {
    var testData: Data!
    var parser: JSONParser<Beer>!
    
    override func setUp() {
        super.setUp()
        
        let testFileLocation = Bundle(for: type(of: self)).url(forResource: "testBeerIngredientJSON", withExtension: "json")!
        testData = try? Data(contentsOf: testFileLocation)
        parser = JSONParser<Beer>(rawData: testData)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func performJSONExtractAndWait(_ description: String, completionHandler: @escaping (([Beer]?)->Void)) {
        let expectation = self.expectation(description: description)
        
        parser.extractObjects() { beers in
            expectation.fulfill()
            completionHandler(beers)
        }
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
        }
    }
    
    func testIngredientJSONParserCanBeInitialized() {
        XCTAssertNotNil(parser)
    }
    
    func testJSONParserFailsInitializationWithInvalidData() {
        let parser = JSONParser<Ingredient>(rawData: "invalid data".data(using: .utf8)!)
        XCTAssertNil(parser)
    }
    
    func testIngredientJSONParserSetsRawData() {
        XCTAssertEqual(parser.rawData, testData)
    }
    
    func testIngredientJSONParserExtractsCurrentPage() {
        performJSONExtractAndWait("Parser should extract current page") { Ingredients in
            XCTAssertEqual(self.parser.currentPage, 1)
        }
    }
    
    // MARK: Hops
    func testIngredientJSONParserExtractsFirstHopName() {
        performJSONExtractAndWait("Parser should extract first hop name") { beers in
            XCTAssertEqual(beers?[0].ingredientSet?.hops[0].name, "Perle (American)")
        }
    }
    
    func testIngredientJSONParserExtractsFirstHopdescription() {
        performJSONExtractAndWait("Parser should extract first hop description") { beers in
            XCTAssertEqual(beers?[0].ingredientSet?.hops[0].summary, "Bred in Germany from Northern Brewer, Perle was an attempt at a higher-alpha replacement for Hallertauer Mittelfr?her. It has a pleasant aroma with a minty character. American versions have a very different profile than those grown in Germany.")
        }
    }
    
    func testIngredientJSONParserExtractsFirstHopcountryOfOrigin() {
        performJSONExtractAndWait("Parser should extract first hop countryOfOrigin") { beers in
            XCTAssertEqual(beers?[0].ingredientSet?.hops[0].countryOfOrigin, "US")
        }
    }
    
    func testIngredientJSONParserExtractsFirstHopalphaAcidMin() {
        performJSONExtractAndWait("Parser should extract first hop alphaAcidMin") { beers in
            XCTAssertEqual(beers?[0].ingredientSet?.hops[0].alphaAcidMin, 7)
        }
    }
    
    func testIngredientJSONParserExtractsFirstHopbetaAcidMin() {
        performJSONExtractAndWait("Parser should extract first hop betaAcidMin") { beers in
            XCTAssertEqual(beers?[0].ingredientSet?.hops[0].betaAcidMin, 4)
        }
    }
    
    func testIngredientJSONParserExtractsFirstHopbetaAcidMax() {
        performJSONExtractAndWait("Parser should extract first hop betaAcidMax") { beers in
            XCTAssertEqual(beers?[0].ingredientSet?.hops[0].betaAcidMax, 5)
        }
    }
    
    func testIngredientJSONParserExtractsFirstHophumuleneMin() {
        performJSONExtractAndWait("Parser should extract first hop humuleneMin") { beers in
            XCTAssertEqual(beers?[0].ingredientSet?.hops[0].humuleneMin, 28)
        }
    }
    
    func testIngredientJSONParserExtractsFirstHophumuleneMax() {
        performJSONExtractAndWait("Parser should extract first hop humuleneMax") { beers in
            XCTAssertEqual(beers?[0].ingredientSet?.hops[0].humuleneMax, 33)
        }
    }
    
    func testIngredientJSONParserExtractsFirstHopcaryophylleneMin() {
        performJSONExtractAndWait("Parser should extract first hop caryophylleneMin") { beers in
            XCTAssertEqual(beers?[0].ingredientSet?.hops[0].caryophylleneMin, 10)
        }
    }
    
    func testIngredientJSONParserExtractsFirstHopcaryophylleneMax() {
        performJSONExtractAndWait("Parser should extract first hop caryophylleneMax") { beers in
            XCTAssertEqual(beers?[0].ingredientSet?.hops[0].caryophylleneMax, 12)
        }
    }
    
    func testIngredientJSONParserExtractsFirstHopcohumuloneMin() {
        performJSONExtractAndWait("Parser should extract first hop cohumuloneMin") { beers in
            XCTAssertEqual(beers?[0].ingredientSet?.hops[0].cohumuloneMin, 27)
        }
    }
    
    func testIngredientJSONParserExtractsFirstHopcohumuloneMax() {
        performJSONExtractAndWait("Parser should extract first hop cohumuloneMax") { beers in
            XCTAssertEqual(beers?[0].ingredientSet?.hops[0].cohumuloneMax, 32)
        }
    }
    
    func testIngredientJSONParserExtractsFirstHopmyrceneMin() {
        performJSONExtractAndWait("Parser should extract first hop myrceneMin") { beers in
            XCTAssertEqual(beers?[0].ingredientSet?.hops[0].myrceneMin, 45)
        }
    }
    
    func testIngredientJSONParserExtractsFirstHopmyrceneMax() {
        performJSONExtractAndWait("Parser should extract first hop myrceneMax") { beers in
            XCTAssertEqual(beers?[0].ingredientSet?.hops[0].myrceneMax, 55)
        }
    }
    
    func testIngredientJSONParserExtractsFirstHopfarneseneMax() {
        performJSONExtractAndWait("Parser should extract first hop farneseneMax") { beers in
            XCTAssertEqual(beers?[0].ingredientSet?.hops[0].farneseneMax, 1)
        }
    }
    
    func testIngredientJSONParserExtractsFirstHopcategory() {
        performJSONExtractAndWait("Parser should extract first hop category") { beers in
            XCTAssertEqual(beers?[0].ingredientSet?.hops[0].category, "hop")
        }
    }
    
    func testIngredientJSONParserExtractsFirstHopcategoryDisplay() {
        performJSONExtractAndWait("Parser should extract first hop categoryDisplay") { beers in
            XCTAssertEqual(beers?[0].ingredientSet?.hops[0].categoryDisplay, "Hops")
        }
    }
    
    func testIngredientJSONParserExtractsFirstHopid() {
        performJSONExtractAndWait("Parser should extract first hop id") { beers in
            XCTAssertEqual(beers?[0].ingredientSet?.hops[0].identifier, 98)
        }
    }
    
}

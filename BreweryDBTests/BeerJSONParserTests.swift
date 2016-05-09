//
//  BeerJSONParserTests.swift
//  BreweryDB
//
//  Created by Jake Welton on 30/04/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import XCTest
@testable import BreweryDB

class BeerJSONParserTests: XCTestCase {
    var testData: NSData!
    var parser: JSONParser<Beer>!
    
    override func setUp() {
        super.setUp()
        
        let testFileLocation = NSBundle(forClass: self.dynamicType).URLForResource("testBeerJSON", withExtension: "json")!
        testData = NSData(contentsOfURL: testFileLocation)
        parser = JSONParser<Beer>(rawData: testData)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func performJSONExtractAndWait(description: String, completionHandler: (([Beer]?)->Void)) {
        let expectation = expectationWithDescription(description)
        
        parser.extractObjectsWithCompletionHandler() { beers in
            expectation.fulfill()
            completionHandler(beers)
        }
        
        waitForExpectationsWithTimeout(5) { error in
            XCTAssertNil(error)
        }
    }
    
    func testBeerJSONParserCanBeInitialized() {
        XCTAssertNotNil(parser)
    }
    
    func testJSONParserFailsInitializationWithInvalidData() {
        let parser = JSONParser<Beer>(rawData: "invalid data".dataUsingEncoding(.allZeros)!)
        XCTAssertNil(parser)
    }
    
    func testBeerJSONParserSetsRawData() {
        XCTAssertEqual(parser.rawData, testData)
    }
    
    func testBeerJSONParserExtractsCurrentPage() {
        performJSONExtractAndWait("Parser should extract current page") { beers in
            XCTAssertEqual(self.parser.currentPage, 1)
        }
    }
    
    func testBeerJSONParserExtractsTotalPageNumber() {
        performJSONExtractAndWait("Parser should extract total number of pages") { beers in
            XCTAssertEqual(self.parser.totalNumberOfPages, 20)
        }
    }
    
    func testBeerJSONParserExtractsTotalResults() {
        performJSONExtractAndWait("Parser should extract total results") { beers in
            XCTAssertEqual(self.parser.totalResults, 964)
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerName() {
        performJSONExtractAndWait("Parser should extract first beer name") { beers in
            XCTAssertEqual(beers?[0].name, "'Heifer' Weizen")
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerIdentifier() {
        performJSONExtractAndWait("Parser should extract first beer identifier") { beers in
            XCTAssertEqual(beers?[0].identifier, "DOc9Bw")
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerDescription() {
        performJSONExtractAndWait("Parser should extract first beer description") { beers in
            XCTAssertEqual(beers?[0].beerDescription, "The aroma and flavor of a Weissbier with yeast is decidedly fruity and phenolic. The phenolic characteristics are often described as clove-, nutmeg-like, mildly smoke-like or even vanilla-like. Banana-like esters should be present at low to medium-high levels. These beers are made with at least 50 percent malted wheat, and hop rates are quite low. Hop flavor and aroma are absent or present at very low levels. Weissbier is well attenuated and very highly carbonated and a medium to full bodied beer. The color is very pale to pale amber. Because yeast is present, the beer will have yeast flavor and a characteristically fuller mouthfeel and may be appropriately very cloudy. No diacetyl should be perceived.")
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerOriginalGravity() {
        performJSONExtractAndWait("Parser should extract first beer original gravity") { beers in
            XCTAssertEqual(beers?[0].originalGravity, 5.3)
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerAbv() {
        performJSONExtractAndWait("Parser should extract first beer abv") { beers in
            XCTAssertEqual(beers?[0].abv, 5.2)
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerIbu() {
        performJSONExtractAndWait("Parser should extract first beer ibu") { beers in
            XCTAssertEqual(beers?[0].ibu, 16)
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerIsOrganic() {
        performJSONExtractAndWait("Parser should extract first beer isOrganic property") { beers in
            XCTAssertEqual(beers?[0].isOrganic, false)
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerServingTemperature() {
        performJSONExtractAndWait("Parser should extract first beer serving temperature") { beers in
            XCTAssertEqual(beers?[0].servingTemperature, "cold")
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerSeringTemperatureDisplay() {
        performJSONExtractAndWait("Parser should extract first beer serving temperature display") { beers in
            XCTAssertEqual(beers?[0].servingTemperatureDisplay, "Cold - (4-7C/39-45F)")
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerStatus() {
        performJSONExtractAndWait("Parser should extract first beer status") { beers in
            XCTAssertEqual(beers?[0].status, "verified")
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerStatusDisplay() {
        performJSONExtractAndWait("Parser should extract first beer status display") { beers in
            XCTAssertEqual(beers?[0].statusDisplay, "Verified")
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerIconImage() {
        performJSONExtractAndWait("Parser should extract first beer icon image") { beers in
            XCTAssertEqual(beers?[0].imageURLSet?.icon, NSURL(string: "https://s3.amazonaws.com/brewerydbapi/beer/thTbY7/upload_jxcOpY-icon.png"))
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerMediumImage() {
        performJSONExtractAndWait("Parser should extract first beer icon image") { beers in
            XCTAssertEqual(beers?[0].imageURLSet?.medium, NSURL(string: "https://s3.amazonaws.com/brewerydbapi/beer/thTbY7/upload_jxcOpY-medium.png"))
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerLargeImage() {
        performJSONExtractAndWait("Parser should extract first beer large image") { beers in
            XCTAssertEqual(beers?[0].imageURLSet?.large, NSURL(string: "https://s3.amazonaws.com/brewerydbapi/beer/thTbY7/upload_jxcOpY-large.png"))
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerYear() {
        performJSONExtractAndWait("Parser should extract first beer year") { beers in
            XCTAssertEqual(beers?[0].year, 2010)
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerGlassID() {
        performJSONExtractAndWait("Parser should extract first beer glass id") { beers in
            XCTAssertEqual(beers?[0].glass?.identifier, 9)
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerGlassName() {
        performJSONExtractAndWait("Parser should extract first beer glass name") { beers in
            XCTAssertEqual(beers?[0].glass?.name, "Weizen")
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerStyleID() {
        performJSONExtractAndWait("Parser should extract first beer style ID") { beers in
            XCTAssertEqual(beers?[0].style?.identifier, 48)
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerStyleCategoryID() {
        performJSONExtractAndWait("Parser should extract first beer style category ID") { beers in
            XCTAssertEqual(beers?[0].style?.categoryID, 4)
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerStyleName() {
        performJSONExtractAndWait("Parser should extract first beer style name") { beers in
            XCTAssertEqual(beers?[0].style?.name, "South German-Style Hefeweizen / Hefeweissbier")
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerStyleShortName() {
        performJSONExtractAndWait("Parser should extract first beer style short name") { beers in
            XCTAssertEqual(beers?[0].style?.shortName, "Hefeweizen")
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerStyleDescription() {
        performJSONExtractAndWait("Parser should extract first beer style description") { beers in
            XCTAssertEqual(beers?[0].style?.description, "The aroma and flavor of a Weissbier with yeast is decidedly fruity and phenolic. The phenolic characteristics are often described as clove-, nutmeg-like, mildly smoke-like or even vanilla-like. Banana-like esters should be present at low to medium-high levels. These beers are made with at least 50 percent malted wheat, and hop rates are quite low. Hop flavor and aroma are absent or present at very low levels. Weissbier is well attenuated and very highly carbonated and a medium to full bodied beer. The color is very pale to pale amber. Because yeast is present, the beer will have yeast flavor and a characteristically fuller mouthfeel and may be appropriately very cloudy. No diacetyl should be perceived.")
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerStyleIbuMin() {
        performJSONExtractAndWait("Parser should extract first beer style name") { beers in
            XCTAssertEqual(beers?[0].style?.ibuMin, 10)
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerStyleIbuMax() {
        performJSONExtractAndWait("Parser should extract first beer style ibu max") { beers in
            XCTAssertEqual(beers?[0].style?.ibuMax, 15)
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerStyleAbvMin() {
        performJSONExtractAndWait("Parser should extract first beer style abv min") { beers in
            XCTAssertEqual(beers?[0].style?.abvMin, 4.9)
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerStyleAbvMax() {
        performJSONExtractAndWait("Parser should extract first beer style abv max") { beers in
            XCTAssertEqual(beers?[0].style?.abvMax, 5.5)
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerStyleSrmMin() {
        performJSONExtractAndWait("Parser should extract first beer style srm min") { beers in
            XCTAssertEqual(beers?[0].style?.srmMin, 3)
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerStyleSrmMax() {
        performJSONExtractAndWait("Parser should extract first beer style srm max") { beers in
            XCTAssertEqual(beers?[0].style?.srmMax, 9)
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerStyleOgMin() {
        performJSONExtractAndWait("Parser should extract first beer style og min") { beers in
            XCTAssertEqual(beers?[0].style?.ogMin, 1.047)
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerStyleOgMax() {
        performJSONExtractAndWait("Parser should extract first beer style ogMax") { beers in
            XCTAssertEqual(beers?[0].style?.ogMax, 1.050)
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerStyleFgMin() {
        performJSONExtractAndWait("Parser should extract first beer style fg min") { beers in
            XCTAssertEqual(beers?[0].style?.fgMin, 1.008)
        }
    }
    
    func testBeerJSONParserExtractsFirstBeerStyleFgMax() {
        performJSONExtractAndWait("Parser should extract first beer style fg max") { beers in
            XCTAssertEqual(beers?[0].style?.fgMax, 1.016)
        }
    }
}

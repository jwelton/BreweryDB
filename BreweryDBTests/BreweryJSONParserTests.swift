//
//  BreweryJSONParserTests.swift
//  BreweryDB
//
//  Created by Jake Welton on 02/05/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import XCTest
@testable import BreweryDB

class BreweryJSONParserTests: XCTestCase {
    var testData: Data!
    var parser: JSONParser<Brewery>!
    
    override func setUp() {
        super.setUp()
        
        let testFileLocation = Bundle(for: type(of: self)).url(forResource: "testBreweryJSON", withExtension: "json")!
        testData = try? Data(contentsOf: testFileLocation)
        parser = JSONParser<Brewery>(rawData: testData)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func performJSONExtractAndWait(_ description: String, completionHandler: @escaping (([Brewery]?)->Void)) {
        let expectation = self.expectation(description: description)
        
        parser.extractObjects() { breweries in
            expectation.fulfill()
            completionHandler(breweries)
        }
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
        }
    }
    
    func testBeerJSONParserCanBeInitialized() {
        XCTAssertNotNil(parser)
    }
    
    func testJSONParserFailsInitializationWithInvalidData() {
        let parser = JSONParser<Beer>(rawData: "invalid data".data(using: .utf8)!)
        XCTAssertNil(parser)
    }
    
    func testBreweryJSONParserSetsRawData() {
        XCTAssertEqual(parser.rawData, testData)
    }
    
    func testBreweryJSONParserExtractsCurrentPage() {
        performJSONExtractAndWait("Parser should extract current page") { beers in
            XCTAssertEqual(self.parser.currentPage, 1)
        }
    }
    
    func testBreweryJSONParserExtractsTotalPageNumber() {
        performJSONExtractAndWait("Parser should extract total number of pages") { beers in
            XCTAssertEqual(self.parser.totalNumberOfPages, 2)
        }
    }
    
    func testBreweryJSONParserExtractsTotalResults() {
        performJSONExtractAndWait("Parser should extract total results") { beers in
            XCTAssertEqual(self.parser.totalResults, 63)
        }
    }
    
    func testBreweryJSONParserExtractsBreweryIdentifier() {
        performJSONExtractAndWait("Parser should extract brewery identifier") { breweries in
            XCTAssertEqual(breweries?[0].identifier, "sPZjl6")
        }
    }
    
    func testBreweryJSONParserExtractsBreweryName() {
        performJSONExtractAndWait("Parser should extract brewery name") { breweries in
            XCTAssertEqual(breweries?[0].name, "Bastone Brewery")
        }
    }
    
    func testBreweryJSONParserExtractsBreweryEstablished() {
        performJSONExtractAndWait("Parser should extract brewery established date") { breweries in
            XCTAssertEqual(breweries?[0].established, 2004)
        }
    }
    
    func testBreweryJSONParserExtractsBreweryIsOrganic() {
        performJSONExtractAndWait("Parser should extract brewery isOrganic property") { breweries in
            XCTAssertEqual(breweries?[0].isOrganic, false)
        }
    }
    
    func testBreweryJSONParserExtractsBreweryDescription() {
        performJSONExtractAndWait("Parser should extract brewery description") { breweries in
            XCTAssertEqual(breweries?[0].breweryDescription, "Bastone first opened its doors in May of 2004. It is named and styled after the famous Belgian city (though the spelling has been simplified). This unique restaurant and brewery is housed in a 1930’s era building, the exterior of which has been restored to it’s original art deco look in association with the State of Michigan Historical Society. Inside, the high arched ceiling, wood floors and white subway wall tiles create the comfortable yet sophisticated atmosphere of a European brasserie.")
        }
    }
    
    func testBreweryJSONParserExtractsBreweryWebsite() {
        performJSONExtractAndWait("Parser should extract brewery website") { breweries in
            XCTAssertEqual(breweries?[0].website, URL(string: "http://bastone.net/")!)
        }
    }
    
    func testBreweryJSONParserExtractsBreweryMailingListURL() {
        performJSONExtractAndWait("Parser should extract brewery mailing list URL") { breweries in
            XCTAssertEqual(breweries?[0].mailingListURL, URL(string: "http://mailing.bastone.net/")!)
        }
    }
    
    func testBreweryJSONParserExtractsFirstBreweryIconImage() {
        performJSONExtractAndWait("Parser should extract first brewery icon image") { breweries in
            XCTAssertEqual(breweries?[0].imageURLSet?.icon, URL(string: "https://s3.amazonaws.com/brewerydbapi/brewery/sPZjl6/upload_bPzu2H-icon.png"))
        }
    }
    
    func testBreweryJSONParserExtractsFirstBreweryMediumImage() {
        performJSONExtractAndWait("Parser should extract first brewery medium image") { breweries in
            XCTAssertEqual(breweries?[0].imageURLSet?.medium, URL(string: "https://s3.amazonaws.com/brewerydbapi/brewery/sPZjl6/upload_bPzu2H-medium.png"))
        }
    }
    
    func testBreweryJSONParserExtractsFirstBreweryLargeImage() {
        performJSONExtractAndWait("Parser should extract first brewery large image") { breweries in
            XCTAssertEqual(breweries?[0].imageURLSet?.large, URL(string: "https://s3.amazonaws.com/brewerydbapi/brewery/sPZjl6/upload_bPzu2H-large.png"))
        }
    }
    
    func testBreweryJSONParserExtractsFirstBrewerySquareMediumImage() {
        performJSONExtractAndWait("Parser should extract first brewery square medium image") { breweries in
            XCTAssertEqual(breweries?[0].imageURLSet?.squareMedium, URL(string: "https://s3.amazonaws.com/brewerydbapi/brewery/sPZjl6/upload_bPzu2H-squareMedium.png"))
        }
    }
    
    func testBreweryJSONParserExtractsFirstBrewerySquareLargeImage() {
        performJSONExtractAndWait("Parser should extract first brewery square large image") { breweries in
            XCTAssertEqual(breweries?[0].imageURLSet?.squareLarge, URL(string: "https://s3.amazonaws.com/brewerydbapi/brewery/sPZjl6/upload_bPzu2H-squareLarge.png"))
        }
    }

}

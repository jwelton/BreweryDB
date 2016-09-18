//
//  GlassTests.swift
//  BreweryDB
//
//  Created by Jake Welton on 9/18/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import XCTest
@testable import BreweryDB

class GlassTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGlassCanBeInitializedWithIdentifier() {
        let glass: Glass? = Glass(identifier: 1)
        
        XCTAssertNotNil(glass)
    }
    
    func testGlassCanBeDeinitialized() {
        var glass: Glass? = Glass(identifier: 1)
        glass = nil
        XCTAssertNil(glass)
    }
    
    func testGlassCanSetIdentifier() {
        let testData = 1
        
        let glass = Glass(identifier: testData)
        XCTAssertEqual(testData, glass.identifier)
    }
    
    func testGlassCanSetName() {
        let testData = "TestData"
        
        let glass = Glass(identifier: 1)
        glass.name = testData
        XCTAssertEqual(testData, glass.name)
    }
    
}

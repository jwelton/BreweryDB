//
//  BeerJSONParser.swift
//  BreweryDB
//
//  Created by Jake Welton on 30/04/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

typealias JSON = [String: AnyObject]

class BeerJSONParser {
    let rawData: NSData
    let decodedData: JSON
    
    init?(rawData data: NSData) {
        rawData = data
        
        guard let decodedJSON = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? JSON else {
            print("BreweryDB: Invalid data. Unable to decode data into object.")
            return nil
        }
        
        decodedData = decodedJSON
    }
    
    func extractBeerWithCompletionHandler(completionHandler: (([Beer])->Void)?) {
        
    }
}
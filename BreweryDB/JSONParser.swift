//
//  BeerJSONParser.swift
//  BreweryDB
//
//  Created by Jake Welton on 30/04/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

typealias JSON = [String: AnyObject]

protocol JSONParserEntity {
    static func mapJSONToObject(json: JSON) -> AnyObject?
}

class JSONParser<T where T: JSONParserEntity>{
    let rawData: NSData
    let decodedData: JSON
    var currentPage: Int?
    var totalNumberOfPages: Int?
    var totalResults: Int?
    var extractedEntities = [T]()
    
    init?(rawData data: NSData) {
        rawData = data
        
        guard let decodedJSON = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? JSON else {
            print("BreweryDB: Invalid data. Unable to decode data into object.")
            return nil
        }
        
        decodedData = decodedJSON
    }
    
    func extractObjectsWithCompletionHandler(completionHandler: (([T]?)->Void)) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            self.currentPage = self.decodedData["currentPage"] as? Int
            self.totalNumberOfPages = self.decodedData["numberOfPages"] as? Int
            self.totalResults = self.decodedData["totalResults"] as? Int
            
            guard let extractedData = self.decodedData["data"] as? [JSON] else {
                completionHandler(nil)
                return
            }
            
            for rawEntity in extractedData {
                if let newObject = T.mapJSONToObject(rawEntity) as? T {
                    self.extractedEntities.append(newObject)
                }
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                completionHandler(self.extractedEntities)
            }
        }
    }
}
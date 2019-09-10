//
//  JSONParser.swift
//  BreweryDB
//
//  Created by Jake Welton on 30/04/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public typealias json = [String: AnyObject]

public protocol JSONParserEntity {
    static func map(json: json) -> AnyObject?
}

public class JSONParser<T> where T: JSONParserEntity{
    public let rawData: Data
    public let decodedData: json
    public var currentPage: Int?
    public var totalNumberOfPages: Int?
    public var totalResults: Int?
    public var extractedEntities = [T]()
    
    public init?(rawData data: Data) {
        rawData = data
        
        guard let decodedJSON = (try? JSONSerialization.jsonObject(with: data, options: [])) as? json else {
            print("BreweryDB: Invalid data. Unable to decode data into object.")
            return nil
        }
        
        decodedData = decodedJSON
    }
    
    public func extractObjects(using completionHandler: @escaping (([T]?)->Void)) {
        DispatchQueue.global(qos: .background).async {
            self.currentPage = self.decodedData["currentPage"] as? Int
            self.totalNumberOfPages = self.decodedData["numberOfPages"] as? Int
            self.totalResults = self.decodedData["totalResults"] as? Int
            
            guard let extractedData = self.decodedData["data"] as? [json] else {
                completionHandler(nil)
                return
            }
            
            for rawEntity in extractedData {
                if let newObject = T.map(json: rawEntity) as? T {
                    self.extractedEntities.append(newObject)
                }
            }
            
            DispatchQueue.main.async {
                completionHandler(self.extractedEntities)
            }
        }
    }
}

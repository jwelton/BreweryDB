//
//  Search.swift
//  BreweryDB
//
//  Created by Jake Welton on 2016-07-22.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

enum SearchResultType: String {
    case Beer = "beer"
    case Brewery = "brewery"
}

public class Search {
    public let beer: Beer?
    public let brewery: Brewery?
    
    public init(beer: Beer? = nil, brewery: Brewery? = nil) {
        self.beer = beer
        self.brewery = brewery
    }
}

extension Search: JSONParserEntity {
    public static func mapJSONToObject(json: JSON) -> AnyObject? {
        guard let rawType = json["type"] as? String,
            let type = SearchResultType(rawValue: rawType) else {
                return nil
        }
        
        switch type {
        case .Beer:
            return Search(beer: Beer.mapJSONToObject(json) as? Beer)
        case .Brewery:
            return Search(brewery: Brewery.mapJSONToObject(json) as? Brewery)
        }
    }
}
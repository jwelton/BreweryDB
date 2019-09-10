//
//  Search.swift
//  BreweryDB
//
//  Created by Jake Welton on 2016-07-22.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

enum SearchResultType: String {
    case beer = "beer"
    case brewery = "brewery"
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
    public static func map(json: json) -> AnyObject? {
        guard let rawType = json["type"] as? String,
            let type = SearchResultType(rawValue: rawType) else {
                return nil
        }
        
        switch type {
        case .beer:
            return Search(beer: Beer.map(json: json) as? Beer)
        case .brewery:
            return Search(brewery: Brewery.map(json: json) as? Brewery)
        }
    }
}

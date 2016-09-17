//
//  SearchRequest.swift
//  BreweryDB
//
//  Created by Jake Welton on 2016-07-22.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public enum SearchRequestParam: String {
    case SearchTerm = "q"
    case Type = "type"
    case PageNumber = "p"
    case WithBreweries = "withBreweries"
}

public struct SearchRequest {
    public var params: [SearchRequestParam: String]?
    public var endpoint: RequestEndPoint{
        return .Search
    }
    
    public init(params: [SearchRequestParam: String]? = nil) {
        self.params = params
    }
}

extension SearchRequest: BreweryDBRequest {
    public var rawParams: [String: String]? {
        return params?.reduce([String: String]()) { previous, item in
            var temp = previous
            temp[item.0.rawValue] = item.1
            return temp
        }
    }
    
    public var rawOrderBy: String? {
        return nil
    }
    
    mutating public func setPageNumber(number: Int) {
        params?[.PageNumber] = String(number)
    }
}
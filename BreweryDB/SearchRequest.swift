//
//  SearchRequest.swift
//  BreweryDB
//
//  Created by Jake Welton on 2016-07-22.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public enum SearchRequestParam: String {
    case searchTerm = "q"
    case resultType = "type"
    case pageNumber = "p"
    case withBreweries = "withBreweries"
}

public struct SearchRequest {
    public var params: [SearchRequestParam: String]?
    public var endpoint: RequestEndPoint{
        return .search
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
    
    public var pageNumber: Int {
        get {
            guard let rawPageNumber = params?[.pageNumber] else {
                return 0
            }
            
            return Int(rawPageNumber) ?? 0
        }
        set {
            params?[.pageNumber] = String(newValue)
        }
    }
}

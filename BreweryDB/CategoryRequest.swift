//
//  CategoryRequest.swift
//  BreweryDB
//
//  Created by Jake Welton on 2016-07-22.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public enum CategoryRequestParam: String {
    case Identifier = "ids"
    case Name = "name"
}

public struct CategoryRequest {
    public var params: [CategoryRequestParam: String]?
    public var endpoint: RequestEndPoint{
        return .Beers
    }
    
    public init(params: [CategoryRequestParam: String]? = nil) {
        self.params = params
    }
}

extension CategoryRequest: BreweryDBRequest {
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
        // Do nothing - Categories have only 1 page
    }
}
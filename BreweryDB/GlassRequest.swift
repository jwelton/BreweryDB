//
//  GlassRequest.swift
//  BreweryDB
//
//  Created by Jake Welton on 2016-07-22.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public enum GlassRequestParam: String {
    case pageNumber = "p"
}

public struct GlassRequest {
    public var params: [GlassRequestParam: String]?
    public var endpoint: RequestEndPoint{
        return .glassware
    }
    
    public init(params: [GlassRequestParam: String]? = nil) {
        self.params = params
    }
}

extension GlassRequest: BreweryDBRequest {
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
                return 1
            }
            
            return Int(rawPageNumber) ?? 1
        }
        set {
            params?[.pageNumber] = String(newValue)
        }
    }
}

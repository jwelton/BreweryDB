//
//  StyleRequest.swift
//  BreweryDB
//
//  Created by Jake Welton on 2016-07-22.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public struct StyleRequest {
    public var endpoint: RequestEndPoint{
        return .styles
    }
    
    public init() {}
}

extension StyleRequest: BreweryDBRequest {
    public var rawParams: [String: String]? {
        return nil
    }
    
    public var rawOrderBy: String? {
        return nil
    }
    
    public var pageNumber: Int {
        get {
            return 0
        }
        set {
            // Do nothing
        }
    }
}

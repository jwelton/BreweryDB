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
        return .Styles
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
    
    mutating public func setPageNumber(number: Int) {
        // Do nothing - styles are all on one page
    }
}
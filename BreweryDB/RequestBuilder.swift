//
//  RequestBuilder.swift
//  BreweryDB
//
//  Created by Jake Welton on 1/30/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

enum RequestEndPoint: String {
    case Beer = "beer"
    case Beers = "beers"
}

extension NSURL {
    func URLByAppendingPathComponent(endPoint: RequestEndPoint) -> NSURL {
        return URLByAppendingPathComponent(endPoint.rawValue)
    }
}

class RequestBuilder {
    
}
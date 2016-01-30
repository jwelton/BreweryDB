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
    let endPoint: RequestEndPoint
    
    init(endPoint: RequestEndPoint) {
        self.endPoint = endPoint
    }
    
    func buildRequest<T : RawRepresentable where T.RawValue == String>(requestParams: [T: String]) -> NSURL {
        let beerRequest = BreweryDBBaseURL.URLByAppendingPathComponent(endPoint)
        
        for param in requestParams {
            beerRequest.URLByAppendingPathComponent(param.0.rawValue)
            beerRequest.URLByAppendingPathComponent(param.1)
        }
        
        return beerRequest
    }
}
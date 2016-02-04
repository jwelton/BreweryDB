//
//  RequestBuilder.swift
//  BreweryDB
//
//  Created by Jake Welton on 1/30/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

enum RequestEndPoint: String {
    case Beers = "beers"
}

extension NSURL {
    func URLByAppendingPathComponent(endPoint: RequestEndPoint) -> NSURL {
        return URLByAppendingPathComponent(endPoint.rawValue)
    }
    
    func URLByAppendingGETVariable<T : RawRepresentable where T.RawValue == String>(param: T, value: String, isFirstVar: Bool) -> NSURL {
        let url = isFirstVar ? "?" : "&"
        let path = url + param.rawValue + "=" + value
        return NSURL(string: self.absoluteString + path)!
    }
}

class RequestBuilder {
    let endPoint: RequestEndPoint
    
    init(endPoint: RequestEndPoint) {
        self.endPoint = endPoint
    }
    
    func buildRequest<T : RawRepresentable where T.RawValue == String>(requestParams: [T: String]) -> NSURL {
        var beerRequest = BreweryDBBaseURL.URLByAppendingPathComponent(endPoint)
        
        for (index, param) in requestParams.enumerate() {
            beerRequest = beerRequest.URLByAppendingGETVariable(param.0, value: param.1, isFirstVar: index == 0 ? true : false)
        }
        
        return beerRequest
    }
}
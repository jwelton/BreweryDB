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
    
    func URLByAppendingGETVariable<T : RawRepresentable where T.RawValue == String>(param: T, value: String) -> NSURL {
        let path = "&" + param.rawValue + "=" + value
        return NSURL(string: self.absoluteString + path)!
    }
}

class RequestBuilder {
    let bugFix = ""
    let endPoint: RequestEndPoint
    
    init(endPoint: RequestEndPoint) {
        self.endPoint = endPoint
    }
    
    func buildRequest<T : RawRepresentable where T.RawValue == String>(requestParams: [T: String]) -> NSURL? {
        let baseURL = BreweryDBBaseURL.URLByAppendingPathComponent(endPoint)
        
        guard let apiKey = BreweryDBApiKey,
            var beerRequest = NSURL(string: baseURL.absoluteString + "?key=\(apiKey)") else {
                print("BreweryDB: Failed to build base URL. Have you set your BreweryDB API key?")
                return nil
        }
        
        for param in requestParams {
            beerRequest = beerRequest.URLByAppendingGETVariable(param.0, value: param.1)
        }
        
        return beerRequest
    }
}
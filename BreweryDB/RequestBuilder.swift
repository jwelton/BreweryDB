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
}

class RequestBuilder {
    let bugFix = ""
    let endPoint: RequestEndPoint
    var apiKeyQueryItem: NSURLQueryItem {
        return NSURLQueryItem(name: "key", value: BreweryDBApiKey)
    }
    
    init(endPoint: RequestEndPoint) {
        self.endPoint = endPoint
    }
    
    func buildRequest<T : RawRepresentable where T.RawValue == String>(requestParams: [T: String]) -> NSURL? {
        guard let _ = BreweryDBApiKey else {
            print("BreweryDB: No Brewery API key set. Please set a valid API key before attempting to perform a request.")
            return nil
        }
        
        let baseURL = BreweryDBBaseURL.URLByAppendingPathComponent(endPoint)
        
        let components = NSURLComponents(URL: baseURL, resolvingAgainstBaseURL: false)
        components?.queryItems = [apiKeyQueryItem]
        
        for param in requestParams {
            let queryItem = NSURLQueryItem(name: param.0.rawValue, value: param.1)
            components?.queryItems?.append(queryItem)
        }
        
        return components?.URL
    }
}
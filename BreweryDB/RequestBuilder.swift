//
//  RequestBuilder.swift
//  BreweryDB
//
//  Created by Jake Welton on 1/30/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public enum RequestEndPoint: String {
    case Beers = "beers"
    case Breweries = "breweries"
    case Categories = "categories"
    case Styles = "styles"
    case Glassware = "glassware"
}

public extension NSURL {
    func URLByAppendingPathComponent(endPoint: RequestEndPoint) -> NSURL {
        return URLByAppendingPathComponent(endPoint.rawValue)
    }
}

public class RequestBuilder {
    let apiKeyQueryItem = NSURLQueryItem(name: "key", value: BreweryDBApiKey)
    let endPoint: RequestEndPoint
    
    public init(endPoint: RequestEndPoint) {
        self.endPoint = endPoint
    }
    
    public func buildRequest(request: BreweryDBRequest) -> NSURLRequest? {
        guard let _ = BreweryDBApiKey else {
            print("BreweryDB: No Brewery API key set. Please set a valid API key before attempting to perform a request.")
            return nil
        }
        
        let baseURL = BreweryDBBaseURL.URLByAppendingPathComponent(endPoint)
        
        let components = NSURLComponents(URL: baseURL, resolvingAgainstBaseURL: false)
        components?.queryItems = [apiKeyQueryItem]
        
        if let params = request.rawParams {
            for param in params {
                let queryItem = NSURLQueryItem(name: param.0, value: param.1)
                components?.queryItems?.append(queryItem)
            }
        }
        
        if let orderParam = request.rawOrderBy {
            let queryItem = NSURLQueryItem(name: "order", value: orderParam)
            components?.queryItems?.append(queryItem)
        }
        
        guard let url = components?.URL else{
            return nil
        }
        
        return NSURLRequest(URL: url)
    }
}
//
//  RequestBuilder.swift
//  BreweryDB
//
//  Created by Jake Welton on 1/30/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public enum RequestEndPoint: String {
    case beers = "beers"
    case breweries = "breweries"
    case categories = "categories"
    case styles = "styles"
    case glassware = "glassware"
    case search = "search"
}

public extension URL {
    func appendingPathComponent(_ endPoint: RequestEndPoint) -> URL {
        return appendingPathComponent(endPoint.rawValue)
    }
}

open class RequestBuilder {
    let apiKeyQueryItem = URLQueryItem(name: "key", value: breweryDBApiKey)
    let endPoint: RequestEndPoint
    
    public init(endPoint: RequestEndPoint) {
        self.endPoint = endPoint
    }
    
    open func buildRequest(_ request: BreweryDBRequest) -> URLRequest? {
        guard let _ = breweryDBApiKey else {
            print("BreweryDB: No Brewery API key set. Please set a valid API key before attempting to perform a request.")
            return nil
        }
        
        let baseURL = breweryDBBaseURL.appendingPathComponent(endPoint)
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        components?.queryItems = [apiKeyQueryItem]
        
        if let params = request.rawParams {
            for param in params {
                let queryItem = URLQueryItem(name: param.0, value: param.1)
                components?.queryItems?.append(queryItem)
            }
        }
        
        if let orderParam = request.rawOrderBy {
            let queryItem = URLQueryItem(name: "order", value: orderParam)
            components?.queryItems?.append(queryItem)
        }
        
        guard let url = components?.url else{
            return nil
        }
        
        return URLRequest(url: url)
    }
}

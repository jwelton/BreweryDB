//
//  RequestBuilder.swift
//  BreweryDB
//
//  Created by Jake Welton on 1/30/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public enum RequestEndPoint {
    case beers
    case breweries
    case categories
    case styles
    case glassware
    case search
    case brewery(String, BreweryEndPoint)
    
    public enum BreweryEndPoint: String {
        case beers = "beers"
    }
    
    var path: String {
        switch self {
        case .beers: return "beers"
        case .breweries: return "breweries"
        case .categories: return "categories"
        case .styles: return "styles"
        case .glassware: return "glassware"
        case .search: return "search"
        case .brewery(let id, let specificEndpoint): return "brewery/\(id)/\(specificEndpoint)"
        }
    }
}

public extension URL {
    func appendingPathComponent(_ endPoint: RequestEndPoint) -> URL {
        return appendingPathComponent(endPoint.path)
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

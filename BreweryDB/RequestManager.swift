//
//  RequestManager.swift
//  BreweryDB
//
//  Created by Jake Welton on 2016-07-21.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public protocol BreweryDBRequest {
    var endpoint: RequestEndPoint { get }
    var params: [String: String]? { get set }
    var orderBy: String? { get }
}

public class RequestManager<Type: JSONParserEntity> {
    private var pageNumber = 0
    private let requestBuilder: RequestBuilder
    private var urlRequest: NSURLRequest
    public var request: BreweryDBRequest
    public var requestURL: NSURLRequest {
        return urlRequest
    }
    public var currentPageNumber: Int {
        return pageNumber
    }
    
    public init?(request: BreweryDBRequest) {
        requestBuilder = RequestBuilder(endPoint: request.endpoint)
        
        guard let url = requestBuilder.buildRequest(request) else {
            return nil
        }
        
        self.request = request
        urlRequest = url
    }
    
    public func loadWithCompletionHandler(completionHandler: ((items: [Type]?)->Void)) {
        NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) { data, response, error in
            guard let returnedData = data,
                let response = response as? NSHTTPURLResponse where response.statusCode == 200 else {
                    completionHandler(items: nil)
                    return
            }
            
            let jsonParser = JSONParser<Type>(rawData: returnedData)
            jsonParser?.extractObjectsWithCompletionHandler(completionHandler)
            
            }.resume()
    }
    
    public func loadNextPageWithCompletionHandler(completionHandler: (items: [Type]?)->Void) {
        let newPageNumber = pageNumber + 1
        
        request.params?["p"] = "\(newPageNumber)"
        pageNumber = newPageNumber
        
        guard let url = requestBuilder.buildRequest(request) else {
            completionHandler(items: nil)
            return
        }
        
        urlRequest = url
        
        loadWithCompletionHandler(completionHandler)
    }
}
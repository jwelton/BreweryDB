//
//  BeerRequest.swift
//  BreweryDB
//
//  Created by Jake on 08/01/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public enum BeerRequestParam: String {
    case Identifier = "ids"
    case Name = "name"
    case Abv = "abv"
    case Ibu = "ibu"
    case IsOrganic = "isOrganic"
    case HasLabels = "hasLabels"
    case Since = "since"
    case Status = "status"
    case RandomCount = "order"
    case PageNumber = "p"
}

public class BeerRequest {
    private var pageNumber = 0
    private let requestBuilder = RequestBuilder(endPoint: .Beers)
    
    public let requestParams: [BeerRequestParam: String]
    public let requestURL: NSURLRequest
    var currentPageNumber: Int {
        return pageNumber
    }
    
    public init?(requestParams params: [BeerRequestParam: String]) {
        guard let url = requestBuilder.buildRequest(params) where params.count != 0 else {
            return nil
        }
        
        requestParams = params
        requestURL = url
    }
    
    public func loadBeersWithCompletionHandler(completionHandler: ((beers: [Beer]?)->Void)) {
        NSURLSession.sharedSession().dataTaskWithRequest(requestURL) { data, response, error in
            guard let returnedData = data,
                let response = response as? NSHTTPURLResponse where response.statusCode == 200 else {
                    completionHandler(beers: nil)
                    return
            }
            
            let jsonParser = JSONParser<Beer>(rawData: returnedData)
            jsonParser?.extractObjectsWithCompletionHandler(completionHandler)

            }.resume()
    }
}

extension BeerRequest: CustomStringConvertible {
    public var description: String {
        var items = ""
        
        for param in requestParams {
            items += param.1
        }
        
        return items
    }
}
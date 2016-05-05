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

public enum BeerRequestOrderParam: String {
    case Name = "name"
    case Description = "description"
    case Abv = "abv"
    case Ibu = "ibu"
    case IsOrganic = "isOrganic"
    case Status = "status"
    case CreateDate = "createDate"
    case UpdateDate = "updateDate"
    case Random = "random"
}

public class BeerRequest {
    private var pageNumber = 0
    private let requestBuilder = RequestBuilder(endPoint: .Beers)
    private var request: NSURLRequest
    
    public let requestParams: [BeerRequestParam: String]
    public var orderParameter: BeerRequestOrderParam? = nil
    public var requestURL: NSURLRequest {
        return request
    }
    public var currentPageNumber: Int {
        return pageNumber
    }
    
    public init?(requestParams params: [BeerRequestParam: String], orderBy order: BeerRequestOrderParam? = nil) {
        guard let url = requestBuilder.buildRequest(params, orderParam: order?.rawValue) where params.count != 0 else {
            return nil
        }
        
        requestParams = params
        orderParameter = order
        request = url
    }
    
    public func loadBeersWithCompletionHandler(completionHandler: ((beers: [Beer]?)->Void)) {
        NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard let returnedData = data,
                let response = response as? NSHTTPURLResponse where response.statusCode == 200 else {
                    completionHandler(beers: nil)
                    return
            }
            
            let jsonParser = JSONParser<Beer>(rawData: returnedData)
            jsonParser?.extractObjectsWithCompletionHandler(completionHandler)

            }.resume()
    }
    
    public func loadNextPageWithCompletionHandler(completionHandler: (beers: [Beer]?)->Void) {
        let newPageNumber = pageNumber + 1
        
        var newParams = requestParams
        newParams[.PageNumber] = "\(newPageNumber)"
        pageNumber = newPageNumber
        
        guard let url = requestBuilder.buildRequest(newParams, orderParam: orderParameter?.rawValue) else {
            completionHandler(beers: nil)
            return
        }
        
        request = url
        
        loadBeersWithCompletionHandler(completionHandler)
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
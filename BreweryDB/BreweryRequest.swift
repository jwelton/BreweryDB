//
//  BreweryRequest.swift
//  BreweryDB
//
//  Created by Jake Welton on 29/04/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public enum BreweryRequestParam: String {
    case Identifier = "ids"
    case Name = "name"
    case Abv = "abv"
    case Ibu = "ibu"
    case GlasswareId = "glasswareId"
    case SrmId = "srmId"
    case AvaliableId = "availableId"
    case StyleId = "styleId"
    case IsOrganic = "isOrganic"
    case HasLabels = "hasLabels"
    case Year = "year"
    case Since = "since"
    case Status = "status"
    case RandomCount = "order"
    case PageNumber = "p"
}

public enum BreweryRequestOrderParam: String {
    case Name = "name"
    case Description = "description"
    case Website = "website"
    case Established = "established"
    case MailingListURL = "mailingListURL"
    case IsOrganic = "isOrganic"
    case Status = "status"
    case CreateDate = "createDate"
    case UpdateDate = "updateDate"
    case Random = "random"
}

public class BreweryRequest {
//    private var pageNumber = 0
//    private let requestBuilder = RequestBuilder(endPoint: .Breweries)
//    private var request: NSURLRequest
//    
//    public let requestParams: [BreweryRequestParam: String]
//    public var orderParameter: BreweryRequestOrderParam?
//    public var requestURL: NSURLRequest {
//        return request
//    }
//    public var currentPageNumber: Int {
//        return pageNumber
//    }
//    
//    public init?(requestParams params: [BreweryRequestParam: String], orderBy order: BreweryRequestOrderParam? = nil) {
//        guard let url = requestBuilder.buildRequest(params, orderParam: order?.rawValue) where params.count != 0 else {
//            return nil
//        }
//        
//        requestParams = params
//        orderParameter = order
//        request = url
//    }
//    
//    public func loadBreweriesWithCompletionHandler(completionHandler: ((breweries: [Brewery]?)->Void)) {
//        NSURLSession.sharedSession().dataTaskWithRequest(requestURL) { data, response, error in
//            guard let returnedData = data,
//                let response = response as? NSHTTPURLResponse where response.statusCode == 200 else {
//                    completionHandler(breweries: nil)
//                    return
//            }
//            
//            let jsonParser = JSONParser<Brewery>(rawData: returnedData)
//            jsonParser?.extractObjectsWithCompletionHandler(completionHandler)
//            
//            }.resume()
//    }
//    
//    public func loadNextPageWithCompletionHandler(completionHandler: (breweries: [Brewery]?)->Void) {
//        let newPageNumber = pageNumber + 1
//        
//        var newParams = requestParams
//        newParams[.PageNumber] = "\(newPageNumber)"
//        pageNumber = newPageNumber
//        
//        guard let url = requestBuilder.buildRequest(newParams, orderParam: orderParameter?.rawValue) else {
//            completionHandler(breweries: nil)
//            return
//        }
//        
//        request = url
//        
//        loadBreweriesWithCompletionHandler(completionHandler)
//    }
}

//extension BreweryRequest: CustomStringConvertible {
//    public var description: String {
//        var items = ""
//        
//        for param in requestParams {
//            items += param.1
//        }
//        
//        return items
//    }
//}
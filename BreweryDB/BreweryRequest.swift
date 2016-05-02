//
//  BreweryRequest.swift
//  BreweryDB
//
//  Created by Jake Welton on 29/04/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

enum BreweryRequestParam: String {
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
}

class BreweryRequest {
    let requestParams: [BreweryRequestParam: String]
    let requestBuilder = RequestBuilder(endPoint: .Breweries)
    
    init?(requestParams params: [BreweryRequestParam: String]) {
        if params.count == 0 {
            return nil
        }
        
        requestParams = params
    }
    
    func loadBreweriesWithCompletionHandler(completionHandler: ((breweries: [Brewery]?)->Void)) {
        guard let url = requestBuilder.buildRequest(requestParams) else {
            completionHandler(breweries: nil)
            return
        }
        
        let urlRequest = NSURLRequest(URL: url)
        
        NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) { data, response, error in
            guard let returnedData = data,
                let response = response as? NSHTTPURLResponse where response.statusCode == 200 else {
                    completionHandler(breweries: nil)
                    return
            }
            
            let jsonParser = JSONParser<Brewery>(rawData: returnedData)
            jsonParser?.extractObjectsWithCompletionHandler(completionHandler)
            
            }.resume()
    }
}
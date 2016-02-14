//
//  BeerRequest.swift
//  BreweryDB
//
//  Created by Jake on 08/01/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

enum BeerRequestParam: String {
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

class BeerRequest {
    let requestParams: [BeerRequestParam: String]
    let requestBuilder = RequestBuilder(endPoint: .Beers)
    
    init?(requestParams params: [BeerRequestParam: String]) {
        if params.count == 0 {
            requestParams = [:]
            return nil
        }
        
        requestParams = params
    }
    
    func loadBeersWithCompletionHandler(completionHandler: ((beers: [Beer]?)->Void)) {
        guard let url = requestBuilder.buildRequest(requestParams) else {
            completionHandler(beers: nil)
            return
        }
        
        
    }
}
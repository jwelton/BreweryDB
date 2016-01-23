//
//  BeerRequest.swift
//  BreweryDB
//
//  Created by Jake on 08/01/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

enum BeerRequestParam {
    case Identifier
    case Name
    case Abv
    case Ibu
    case GlasswareId
    case SrmId
    case AvaliableId
    case StyleId
    case IsOrganic
    case HasLabels
    case Year
    case Since
    case Status
    case RandomCount
}

class BeerRequest {
    let requestParams: [BeerRequestParam: String]
    
    init?(requestParams params: [BeerRequestParam: String]) {
        if params.count == 0 {
            requestParams = [:]
            return nil
        }
        
        requestParams = params
    }
    
    func loadBeersWithCompletionHandler(completionHandler: ((beers: [Beer])->Void)) {
        
    }
}
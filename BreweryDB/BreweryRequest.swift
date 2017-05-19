//
//  BreweryRequest.swift
//  BreweryDB
//
//  Created by Jake Welton on 29/04/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public enum BreweryRequestParam: String {
    case identifier = "ids"
    case name = "name"
    case abv = "abv"
    case ibu = "ibu"
    case glasswareId = "glasswareId"
    case srmId = "srmId"
    case avaliableId = "availableId"
    case styleId = "styleId"
    case isOrganic = "isOrganic"
    case hasLabels = "hasLabels"
    case year = "year"
    case since = "since"
    case status = "status"
    case randomCount = "order"
    case pageNumber = "p"
    case withBreweries = "withBreweries"
    case withIngredients = "withIngredients"
    case withLocations = "withLocations"
}

public enum BreweryRequestOrderParam: String {
    case name = "name"
    case description = "description"
    case website = "website"
    case established = "established"
    case mailingListURL = "mailingListURL"
    case isOrganic = "isOrganic"
    case status = "status"
    case createDate = "createDate"
    case updateDate = "updateDate"
    case random = "random"
}

public struct BreweryRequest {
    public var params: [BreweryRequestParam: String]?
    public var orderBy: BreweryRequestOrderParam?
    public var brewery: Brewery?
    public var endPoint: RequestEndPoint.BreweryEndPoint?
    public var endpoint: RequestEndPoint{
        guard let brewery = brewery, let endPoint = endPoint else {
            return .breweries
        }
        
        return .brewery(brewery.identifier, endPoint)
    }
    
    public init(brewery: Brewery? = nil, endPoint: RequestEndPoint.BreweryEndPoint? = nil, params: [BreweryRequestParam: String]? = nil, orderBy: BreweryRequestOrderParam? = nil) {
        self.params = params
        self.orderBy = orderBy
        self.brewery = brewery
        self.endPoint = endPoint
    }
}

extension BreweryRequest: BreweryDBRequest {
    public var rawParams: [String: String]? {
        return params?.reduce([String: String]()) { previous, item in
            var temp = previous
            temp[item.0.rawValue] = item.1
            return temp
        }
    }
    
    public var rawOrderBy: String? {
        return orderBy?.rawValue
    }
    
    public var pageNumber: Int {
        get {
            guard let rawPageNumber = params?[.pageNumber] else {
                return 0
            }
            
            return Int(rawPageNumber) ?? 0
        }
        set {
            params?[.pageNumber] = String(newValue)
        }
    }
}

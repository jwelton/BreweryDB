//
//  BeerRequest.swift
//  BreweryDB
//
//  Created by Jake on 08/01/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public enum BeerRequestParam: String {
    case identifier = "ids"
    case name = "name"
    case abv = "abv"
    case ibu = "ibu"
    case isOrganic = "isOrganic"
    case hasLabels = "hasLabels"
    case since = "since"
    case status = "status"
    case randomCount = "randomCount"
    case pageNumber = "p"
    case styleId = "styleId"
    case withBreweries = "withBreweries"
    case withIngredients = "withIngredients"
}

public enum BeerRequestOrderParam: String {
    case name = "name"
    case description = "description"
    case abv = "abv"
    case ibu = "ibu"
    case isOrganic = "isOrganic"
    case status = "status"
    case createDate = "createDate"
    case updateDate = "updateDate"
    case random = "random"
}

public struct BeerRequest {
    public var params: [BeerRequestParam: String]?
    public var orderBy: BeerRequestOrderParam?
    public var endpoint: RequestEndPoint{
        return .beers
    }
    
    public init(params: [BeerRequestParam: String]? = nil, orderBy: BeerRequestOrderParam? = nil) {
        self.params = params
        self.orderBy = orderBy
    }
}

extension BeerRequest: BreweryDBRequest {
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

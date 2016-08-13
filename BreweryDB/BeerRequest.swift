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
    case RandomCount = "randomCount"
    case PageNumber = "p"
    case StyleId = "styleId"
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

public struct BeerRequest {
    public var params: [BeerRequestParam: String]?
    public var orderBy: BeerRequestOrderParam?
    public var endpoint: RequestEndPoint{
        return .Beers
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
    
    mutating public func setPageNumber(number: Int) {
        params?[.PageNumber] = String(number)
    }
}
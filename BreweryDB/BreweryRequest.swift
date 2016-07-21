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

public struct BreweryRequest {
    public var params: [BreweryRequestParam: String]?
    public var orderBy: BreweryRequestOrderParam?
    public var endpoint: RequestEndPoint{
        return .Breweries
    }
    
    init(params: [BreweryRequestParam: String]? = nil, orderBy: BreweryRequestOrderParam? = nil) {
        self.params = params
        self.orderBy = orderBy
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
    
    mutating public func setPageNumber(number: Int) {
        params?[.PageNumber] = String(number)
    }
}
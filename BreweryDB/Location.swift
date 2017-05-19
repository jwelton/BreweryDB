//
//  Location.swift
//  BreweryDB
//
//  Created by Jake Welton on 19/05/2017.
//  Copyright © 2017 Jake Welton. All rights reserved.
//

import Foundation

class Location {
    public let identifier: String
    public var name: String?
    public var streetAddress: String?
    public var locality: String?
    public var region: String?
    public var postalCode: String?
    public var phone: String?
    public var website: String?
    public var latitude: Double?
    public var longitude: Double?
    public var isPrimary: Bool?
    public var inPlanning: Bool?
    public var isClosed: Bool?
    public var openToPublic: Bool?
    public var locationType: String?
    public var locationTypeDisplay: String?
    public var countryIsoCode: String?
    public var status: String?
    public var statusDisplay: String?
    
    public init(identifier: String) {
        self.identifier = identifier
    }
}

extension Location: JSONParserEntity {
    public static func map(json: json) -> AnyObject? {
        guard let identifier = json["id"] as? String else {
            return nil
        }
        
        let location = Location(identifier: identifier)
        location.name = json["name"] as? String
        location.streetAddress = json["streetAddress"] as? String
        location.locality = json["locality"] as? String
        location.region = json["region"] as? String
        location.postalCode = json["postalCode"] as? String
        location.phone = json["phone"] as? String
        location.website = json["website"] as? String
        location.locationType = json["locationType"] as? String
        location.locationTypeDisplay = json["locationTypeDisplay"] as? String
        location.countryIsoCode = json["countryIsoCode"] as? String
        location.status = json["status"] as? String
        location.statusDisplay = json["statusDisplay"] as? String
        location.longitude = json["longitude"] as? Double
        location.latitude = json["latitude"] as? Double
        location.isPrimary = json["isPrimary"] as? String == "Y"
        location.inPlanning = json["inPlanning"] as? String == "Y"
        location.isClosed = json["isClosed"] as? String == "Y"
        location.openToPublic = json["openToPublic"] as? String == "Y"
        
        return location
    }
}

extension Location: CustomStringConvertible {
    public var description: String {
        return "Identifier: \(identifier), name: \(name)"
    }
}

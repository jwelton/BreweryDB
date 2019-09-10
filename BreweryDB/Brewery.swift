//
//  Brewery.swift
//  BreweryDB
//
//  Created by Jake Welton on 29/04/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public class Brewery {
    public let identifier: String
    public var name: String?
    public var established: Int?
    public var isOrganic: Bool?
    public var breweryDescription: String?
    public var website: URL?
    public var mailingListURL: URL?
    public var imageURLSet: ImageURLSet?
    public var locations: [Location]?
    
    public init(identifier: String) {
        self.identifier = identifier
    }
}

extension Brewery: JSONParserEntity {
    public static func map(json: json) -> AnyObject? {
        guard let identifier = json["id"] as? String else {
            return nil
        }
        
        let brewery = Brewery(identifier: identifier)
        brewery.name = json["name"] as? String
        
        if let established = json["established"] as? String {
            brewery.established = Int(established)
        }
        
        brewery.isOrganic = json["isOrganic"] as? String == "Y"
        brewery.breweryDescription = json["description"] as? String
        
        if let websiteURL = json["website"] as? String {
            brewery.website = URL(string: websiteURL)
        }
        
        if let mailingListURL = json["mailingListURL"] as? String {
            brewery.mailingListURL = URL(string: mailingListURL)
        }
        
        if let labels = json["images"] as? json {
            brewery.imageURLSet = ImageURLSet.map(json: labels) as? ImageURLSet
        }
        
        if let rawLocations = json["locations"] as? [json] {
            brewery.locations = rawLocations.flatMap{ Location.map(json: $0) as? Location }
        }
        
        return brewery
    }
}

extension Brewery: CustomStringConvertible {
    public var description: String {
        return "Identifier: \(identifier), name: \(name), description: \(breweryDescription)"
    }
}

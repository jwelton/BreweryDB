//
//  Brewery.swift
//  BreweryDB
//
//  Created by Jake Welton on 29/04/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

open class Brewery {
    open let identifier: String
    open var name: String?
    open var established: Int?
    open var isOrganic: Bool?
    open var breweryDescription: String?
    open var website: URL?
    open var mailingListURL: URL?
    open var imageURLSet: ImageURLSet?
    
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
        
        return brewery
    }
}

extension Brewery: CustomStringConvertible {
    public var description: String {
        return "Identifier: \(identifier), name: \(name), description: \(breweryDescription)"
    }
}

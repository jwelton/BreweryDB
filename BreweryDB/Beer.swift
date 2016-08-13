//
//  Beer.swift
//  BreweryDB
//
//  Created by Jake Welton on 1/3/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public class Beer {
    public let identifier: String
    public var name: String?
    public var beerDescription: String?
    public var originalGravity: Float?
    public var abv: Float?
    public var ibu: Float?
    public var isOrganic: Bool?
    public var servingTemperature: String?
    public var servingTemperatureDisplay: String?
    public var status: String?
    public var statusDisplay: String?
    public var imageURLSet: ImageURLSet?
    public var year: Int?
    public var glass: Glass?
    public var available: Available?
    public var style: Style?
    public var breweries: [Brewery]?
    
    public init(identifier: String) {
        self.identifier = identifier
    }
}

extension Beer: JSONParserEntity {    
    public static func mapJSONToObject(rawBeer: JSON) -> AnyObject? {
        guard let identifier = rawBeer["id"] as? String else {
            return nil
        }
        
        let beer = Beer(identifier: identifier)
        beer.name = rawBeer["name"] as? String
        beer.beerDescription = rawBeer["description"] as? String
        
        if let originalGravity = rawBeer["originalGravity"] as? String {
            beer.originalGravity = Float(originalGravity)
        }
        
        if let abv = rawBeer["abv"] as? String {
            beer.abv = Float(abv)
        }
        
        if let ibu = rawBeer["ibu"] as? String {
            beer.ibu = Float(ibu)
        }
        
        beer.isOrganic = rawBeer["isOrganic"] as? String == "Y"
        beer.servingTemperature = rawBeer["servingTemperature"] as? String
        beer.servingTemperatureDisplay = rawBeer["servingTemperatureDisplay"] as? String
        beer.status = rawBeer["status"] as? String
        beer.statusDisplay = rawBeer["statusDisplay"] as? String
        beer.year = rawBeer["year"] as? Int
        
        if let labels = rawBeer["labels"] as? JSON {
            beer.imageURLSet = ImageURLSet.mapJSONToObject(labels) as? ImageURLSet
        }
        
        if let glass = rawBeer["glass"] as? JSON {
            beer.glass = Glass.mapJSONToObject(glass) as? Glass
        }
        
        if let available = rawBeer["available"] as? JSON {
            beer.available = Available.mapJSONToObject(available) as? Available
        }
        
        if let style = rawBeer["style"] as? JSON {
            beer.style = Style.mapJSONToObject(style) as? Style
        }
        
        if let rawBreweries = rawBeer["breweries"] as? [JSON] {
            rawBreweries.forEach{ rawBrewery in
                guard let brewery = Brewery.mapJSONToObject(rawBrewery) as? Brewery else { return }
                beer.breweries?.append(brewery)
            }
        }
        
        return beer
    }
}

extension Beer: CustomStringConvertible {
    public var description: String {
        return "Identifier: \(identifier), name: \(name), description: \(beerDescription), status: \(status)"
    }
}
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
    public var breweries = [Brewery]()
    public var ingredientSet: IngredientSet?
    
    public init(identifier: String) {
        self.identifier = identifier
    }
}

extension Beer: JSONParserEntity {    
    public static func map(json: json) -> AnyObject? {
        guard let identifier = json["id"] as? String else {
            return nil
        }
        
        let beer = Beer(identifier: identifier)
        beer.name = json["name"] as? String
        beer.beerDescription = json["description"] as? String
        
        if let originalGravity = json["originalGravity"] as? String {
            beer.originalGravity = Float(originalGravity)
        }
        
        if let abv = json["abv"] as? String {
            beer.abv = Float(abv)
        }
        
        if let ibu = json["ibu"] as? String {
            beer.ibu = Float(ibu)
        }
        
        beer.isOrganic = json["isOrganic"] as? String == "Y"
        beer.servingTemperature = json["servingTemperature"] as? String
        beer.servingTemperatureDisplay = json["servingTemperatureDisplay"] as? String
        beer.status = json["status"] as? String
        beer.statusDisplay = json["statusDisplay"] as? String
        beer.year = json["year"] as? Int
        
        if let labels = json["labels"] as? json {
            beer.imageURLSet = ImageURLSet.map(json: labels) as? ImageURLSet
        }
        
        if let glass = json["glass"] as? json {
            beer.glass = Glass.map(json: glass) as? Glass
        }
        
        if let available = json["available"] as? json {
            beer.available = Available.map(json: available) as? Available
        }
        
        if let style = json["style"] as? json {
            beer.style = Style.map(json: style) as? Style
        }
        
        if let rawBreweries = json["breweries"] as? [json] {
            rawBreweries.forEach{ rawBrewery in
                guard let brewery = Brewery.map(json: rawBrewery) as? Brewery else { print("Failed mapping of brewery \(beer.name)"); return }
                beer.breweries.append(brewery)
            }
        }
        
        if let rawIngredients = json["ingredients"] as? json {
            let rawHops = rawIngredients["hops"] as? [json] ?? []
            let rawMalts = rawIngredients["malt"] as? [json] ?? []
            let rawMisc = rawIngredients["misc"] as? [json] ?? []
            
            beer.ingredientSet = IngredientSet(rawHops: rawHops, rawMalts: rawMalts, rawMisc: rawMisc)
        }
        
        return beer
    }
}

extension Beer: CustomStringConvertible {
    public var description: String {
        return "Identifier: \(identifier), name: \(name), description: \(beerDescription), status: \(status)"
    }
}

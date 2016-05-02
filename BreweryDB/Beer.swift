//
//  Beer.swift
//  BreweryDB
//
//  Created by Jake Welton on 1/3/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

class Beer {
    let identifier: String
    var name: String?
    var description: String?
    var originalGravity: String?
    var abv: String?
    var ibu: String?
    var isOrganic: Bool?
    var servingTemperature: String?
    var servingTemperatureDisplay: String?
    var status: String?
    var statusDisplay: String?
    var imageURLSet: ImageURLSet?
    
    init(identifier: String) {
        self.identifier = identifier
    }
}

extension Beer: JSONParserEntity {    
    static func mapJSONToObject(rawBeer: JSON) -> AnyObject? {
        guard let identifier = rawBeer["id"] as? String else {
            return nil
        }
        
        let beer = Beer(identifier: identifier)
        beer.name = rawBeer["name"] as? String
        beer.description = rawBeer["description"] as? String
        beer.originalGravity = rawBeer["originalGravity"] as? String
        beer.abv = rawBeer["abv"] as? String
        beer.ibu = rawBeer["ibu"] as? String
        beer.isOrganic = rawBeer["isOrganic"] as? String == "Y"
        beer.servingTemperature = rawBeer["servingTemperature"] as? String
        beer.servingTemperatureDisplay = rawBeer["servingTemperatureDisplay"] as? String
        beer.status = rawBeer["status"] as? String
        beer.statusDisplay = rawBeer["statusDisplay"] as? String
        
        if let labels = rawBeer["labels"] as? JSON {
            beer.imageURLSet = ImageURLSet.mapJSONToObject(labels) as? ImageURLSet
        }
        
        return beer
    }
}
//
//  Ingredient.swift
//  BreweryDB
//
//  Created by Jake Welton on 3/23/17.
//  Copyright © 2017 Jake Welton. All rights reserved.
//

import Foundation

public class Ingredient {
    public let identifier: Int
    public var category: String?
    public var categoryDisplay: String?
    public var name: String?
    public var summary: String?
    public var countryOfOrigin: String?
    public var alphaAcidMin: Float?
    public var betaAcidMin: Float?
    public var betaAcidMax: Float?
    public var humuleneMin: Float?
    public var humuleneMax: Float?
    public var caryophylleneMin: Float?
    public var caryophylleneMax: Float?
    public var cohumuloneMin: Float?
    public var cohumuloneMax: Float?
    public var myrceneMin: Float?
    public var myrceneMax: Float?
    public var farneseneMin: Float?
    public var farneseneMax: Float?
    
    public init(identifier: Int) {
        self.identifier = identifier
    }
}

extension Ingredient: JSONParserEntity {
    public static func map(json: json) -> AnyObject? {
        guard let identifier = json["id"] as? Int else {
            return nil
        }
        
        let ingredient = Ingredient(identifier: identifier)
        ingredient.name = json["name"] as? String
        ingredient.category = json["category"] as? String
        ingredient.categoryDisplay = json["categoryDisplay"] as? String
        ingredient.summary = json["description"] as? String
        ingredient.countryOfOrigin = json["countryOfOrigin"] as? String
        ingredient.alphaAcidMin = json["alphaAcidMin"] as? Float
        ingredient.betaAcidMin = json["betaAcidMin"] as? Float
        ingredient.betaAcidMax = json["betaAcidMax"] as? Float
        ingredient.humuleneMin = json["humuleneMin"] as? Float
        ingredient.humuleneMax = json["humuleneMax"] as? Float
        ingredient.caryophylleneMin = json["caryophylleneMin"] as? Float
        ingredient.caryophylleneMax = json["caryophylleneMax"] as? Float
        ingredient.cohumuloneMin = json["cohumuloneMin"] as? Float
        ingredient.cohumuloneMax = json["cohumuloneMax"] as? Float
        ingredient.myrceneMin = json["myrceneMin"] as? Float
        ingredient.myrceneMax = json["myrceneMax"] as? Float
        ingredient.farneseneMin = json["farneseneMin"] as? Float
        ingredient.farneseneMax = json["farneseneMax"] as? Float
        
        return ingredient
    }
}

extension Ingredient: CustomStringConvertible {
    public var description: String {
        return "Identifier: \(identifier), name: \(name), category: \(category)"
    }
}

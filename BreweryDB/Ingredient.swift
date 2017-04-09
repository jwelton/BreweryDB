//
//  Ingredient.swift
//  BreweryDB
//
//  Created by Jake Welton on 3/23/17.
//  Copyright © 2017 Jake Welton. All rights reserved.
//

import Foundation

open class Ingredient {
    open let identifier: Int
    open var category: String?
    open var categoryDisplay: String?
    open var name: String?
    open var summary: String?
    open var countryOfOrigin: String?
    open var alphaAcidMin: Float?
    open var betaAcidMin: Float?
    open var betaAcidMax: Float?
    open var humuleneMin: Float?
    open var humuleneMax: Float?
    open var caryophylleneMin: Float?
    open var caryophylleneMax: Float?
    open var cohumuloneMin: Float?
    open var cohumuloneMax: Float?
    open var myrceneMin: Float?
    open var myrceneMax: Float?
    open var farneseneMin: Float?
    open var farneseneMax: Float?
    
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

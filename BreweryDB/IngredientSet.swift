//
//  IngredientSet.swift
//  BreweryDB
//
//  Created by Jake Welton on 3/23/17.
//  Copyright © 2017 Jake Welton. All rights reserved.
//

import Foundation

public class IngredientSet {
    public let hops: [Ingredient]
    public let malts: [Ingredient]
    public let misc: [Ingredient]
    
    init(rawHops: [json], rawMalts: [json], rawMisc: [json]) {
        self.hops = rawHops.flatMap{ Ingredient.map(json: $0) as? Ingredient }
        self.malts = rawMalts.flatMap{ Ingredient.map(json: $0) as? Ingredient }
        self.misc = rawMisc.flatMap{ Ingredient.map(json: $0) as? Ingredient }
    }
}

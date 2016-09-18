//
//  Style.swift
//  BreweryDB
//
//  Created by Jake Welton on 5/9/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

open class Style {
    open let identifier: Int
    open var category: Category?
    open var name: String?
    open var shortName: String?
    open var description: String?
    open var ibuMin: Float?
    open var ibuMax: Float?
    open var abvMin: Float?
    open var abvMax: Float?
    open var srmMin: Float?
    open var srmMax: Float?
    open var ogMin: Float?
    open var ogMax: Float?
    open var fgMin: Float?
    open var fgMax: Float?
    
    public init(identifier: Int) {
        self.identifier = identifier
    }
}

extension Style: JSONParserEntity {
    public static func map(json: json) -> AnyObject? {
        guard let identifier = json["id"] as? Int else {
            return nil
        }
        
        let style = Style(identifier: identifier)
        style.name = json["name"] as? String
        style.shortName = json["shortName"] as? String
        style.description = json["description"] as? String
        
        if let ibuMin = json["ibuMin"] as? String {
            style.ibuMin = Float(ibuMin)
        }
        
        if let ibuMax = json["ibuMax"] as? String {
            style.ibuMax = Float(ibuMax)
        }
        
        if let abvMin = json["abvMin"] as? String {
            style.abvMin = Float(abvMin)
        }
        
        if let abvMax = json["abvMax"] as? String {
            style.abvMax = Float(abvMax)
        }
        
        if let srmMin = json["srmMin"] as? String {
            style.srmMin = Float(srmMin)
        }
        
        if let srmMax = json["srmMax"] as? String {
            style.srmMax = Float(srmMax)
        }
        
        if let ogMin = json["ogMin"] as? String {
            style.ogMin = Float(ogMin)
        }
        
        if let ogMax = json["ogMax"] as? String {
            style.ogMax = Float(ogMax)
        }
        
        if let fgMin = json["fgMin"] as? String {
            style.fgMin = Float(fgMin)
        }
        
        if let fgMax = json["fgMax"] as? String {
            style.fgMax = Float(fgMax)
        }
        
        if let category = json["category"] as? json {
            style.category = Category.map(json: category) as? Category
        }
        
        return style
    }
}

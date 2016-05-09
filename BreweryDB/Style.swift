//
//  Style.swift
//  BreweryDB
//
//  Created by Jake Welton on 5/9/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public class Style {
    public let identifier: Int
    public var category: Category?
    public var name: String?
    public var shortName: String?
    public var description: String?
    public var ibuMin: Float?
    public var ibuMax: Float?
    public var abvMin: Float?
    public var abvMax: Float?
    public var srmMin: Float?
    public var srmMax: Float?
    public var ogMin: Float?
    public var ogMax: Float?
    public var fgMin: Float?
    public var fgMax: Float?
    
    public init(identifier: Int) {
        self.identifier = identifier
    }
}

extension Style: JSONParserEntity {
    public static func mapJSONToObject(json: JSON) -> AnyObject? {
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
        
        if let category = json["category"] as? JSON {
            style.category = Category.mapJSONToObject(category) as? Category
        }
        
        return style
    }
}
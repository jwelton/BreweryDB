//
//  Style.swift
//  BreweryDB
//
//  Created by Jake Welton on 5/9/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

class Style {
    let identifier: Int
    var categoryID: Int?
    var name: String?
    var shortName: String?
    var description: String?
    var ibuMin: Float?
    var ibuMax: Float?
    var abvMin: Float?
    var abvMax: Float?
    var srmMin: Float?
    var srmMax: Float?
    var ogMin: Float?
    var ogMax: Float?
    var fgMin: Float?
    var fgMax: Float?
    
    init(identifier: Int) {
        self.identifier = identifier
    }
}

extension Style: JSONParserEntity {
    static func mapJSONToObject(json: JSON) -> AnyObject? {
        guard let identifier = json["identifier"] as? Int else {
            return nil
        }
        
        let style = Style(identifier: identifier)
        style.categoryID = json["categoryID"] as? Int
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
        
        return style
    }
}
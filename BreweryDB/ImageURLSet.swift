//
//  ImageURLSet.swift
//  BreweryDB
//
//  Created by Jake Welton on 02/05/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

class ImageURLSet {
    let icon: NSURL?
    let medium: NSURL?
    let large: NSURL?
    
    init(icon: NSURL?, medium: NSURL?, large: NSURL?) {
        self.icon = icon
        self.medium = medium
        self.large = large
    }
}

extension ImageURLSet: JSONParserEntity {
    static func mapJSONToObject(json: JSON) -> AnyObject? {
        var icon: NSURL?
        var medium: NSURL?
        var large: NSURL?
        
        if let url = json["icon"] as? String {
            icon = NSURL(string: url)
        }
        
        if let url = json["medium"] as? String {
            medium = NSURL(string: url)
        }
        
        if let url = json["large"] as? String {
            large = NSURL(string: url)
        }
        
        return ImageURLSet(icon: icon, medium: medium, large: large)
    }
}
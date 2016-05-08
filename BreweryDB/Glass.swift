//
//  Glass.swift
//  BreweryDB
//
//  Created by Jake Welton on 08/05/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public class Glass {
    let identifier: String
    var name: String?
    
    init(identifier: String) {
        self.identifier = identifier
    }
}

extension Glass: JSONParserEntity {
    public static func mapJSONToObject(json: JSON) -> AnyObject? {
        guard let identifier = json["id"] as? String else {
            return nil
        }
        
        let glass = Glass(identifier: identifier)
        glass.name = json["name"] as? String
        
        return glass
    }
}
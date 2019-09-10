//
//  Glass.swift
//  BreweryDB
//
//  Created by Jake Welton on 08/05/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public class Glass {
    public let identifier: Int
    public var name: String?
    
    public init(identifier: Int) {
        self.identifier = identifier
    }
}

extension Glass: JSONParserEntity {
    public static func map(json: json) -> AnyObject? {
        guard let identifier = json["id"] as? Int else {
            return nil
        }
        
        let glass = Glass(identifier: identifier)
        glass.name = json["name"] as? String
        
        return glass
    }
}

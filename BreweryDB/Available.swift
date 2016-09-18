//
//  Available.swift
//  BreweryDB
//
//  Created by Jake Welton on 5/9/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

open class Available {
    open let identifier: Int
    open var name: String?
    open var description: String?
    
    public init(identifier: Int) {
        self.identifier = identifier
    }
}

extension Available: JSONParserEntity {
    public static func map(json: json) -> AnyObject? {
        guard let identifier = json["id"] as? Int else {
            return nil
        }
        
        let available = Available(identifier: identifier)
        available.name = json["name"] as? String
        available.description = json["description"] as? String
        
        return available
    }
}

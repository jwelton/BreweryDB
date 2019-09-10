//
//  ImageURLSet.swift
//  BreweryDB
//
//  Created by Jake Welton on 02/05/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

public class ImageURLSet {
    public let icon: URL?
    public let medium: URL?
    public let large: URL?
    public let squareMedium: URL?
    public let squareLarge: URL?
    
    public init(icon: URL?, medium: URL?, large: URL?, squareMedium: URL?, squareLarge: URL?) {
        self.icon = icon
        self.medium = medium
        self.large = large
        self.squareMedium = squareMedium
        self.squareLarge = squareLarge
    }
}

extension ImageURLSet: JSONParserEntity {
    public static func map(json: json) -> AnyObject? {
        var icon: URL?
        var medium: URL?
        var large: URL?
        var squareMedium: URL?
        var squareLarge: URL?
        
        if let url = json["icon"] as? String {
            icon = URL(string: url)
        }
        
        if let url = json["medium"] as? String {
            medium = URL(string: url)
        }
        
        if let url = json["large"] as? String {
            large = URL(string: url)
        }
        
        if let url = json["squareMedium"] as? String {
            squareMedium = URL(string: url)
        }
        
        if let url = json["squareLarge"] as? String {
            squareLarge = URL(string: url)
        }
        
        return ImageURLSet(icon: icon, medium: medium, large: large, squareMedium: squareMedium, squareLarge: squareLarge)
    }
}

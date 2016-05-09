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
//
//  Beer.swift
//  BreweryDB
//
//  Created by Jake Welton on 1/3/16.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

class Beer {
    let identifier: String
    var name: String?
    var description: String?
    var originalGravity: String?
    var abv: String?
    var ibu: String?
    var isOrganic: Bool?
    var servingTemperature: String?
    var servingTemperatureDisplay: String?
    var status: String?
    var statusDisplay: String?
    
    init(identifier: String) {
        self.identifier = identifier
    }
}
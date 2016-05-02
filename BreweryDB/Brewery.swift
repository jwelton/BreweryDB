//
//  Brewery.swift
//  BreweryDB
//
//  Created by Jake Welton on 29/04/2016.
//  Copyright © 2016 Jake Welton. All rights reserved.
//

import Foundation

class Brewery {
    let identifier: String
    var name: String?
    var established: Int?
    var isOrganic: Bool?
    var description: String?
    var website: NSURL?
    var mailingListURL: NSURL?
    
    init(identifier: String) {
        self.identifier = identifier
    }
}
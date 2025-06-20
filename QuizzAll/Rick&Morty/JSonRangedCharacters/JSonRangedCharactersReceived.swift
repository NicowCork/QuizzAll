//
//  JSonRangedCharactersReceived.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 23/04/2020.
//  Copyright © 2020 Nicolas Richard. All rights reserved.
//

import Foundation

struct JSonRangedCharactersReceived {

    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: Origin
    var location: Location
    var image: String
    var imageData: Data
    var episode: [String]
    var url: String
    var created: String
        
    struct Origin {
        var name: String
        var url: String
    }
        
    struct Location {
        var name: String
        var url: String
    }
    
}

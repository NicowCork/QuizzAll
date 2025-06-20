//
//  JSonSelectedCharacter.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 18/04/2020.
//  Copyright © 2020 Nicolas Richard. All rights reserved.
//

import Foundation

struct JSonSelectedCharacter: Codable {
    
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    struct Origin: Codable {
        let name: String
        let url: String
    }
    struct Location: Codable {
        let name: String
        let url: String
    }
    
}

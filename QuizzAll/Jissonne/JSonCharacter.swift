//
//  JSonRequest.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 14/04/2020.
//  Copyright © 2020 Nicolas Richard. All rights reserved.
//

import Foundation

struct JSonCharacter: Codable {
    
    let info: Info
    let results: [Results]
    
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String
        let prev: String
    }
    
    struct Origin: Codable {
        let name: String
        let url: String
    }
    struct Location: Codable {
        let name: String
        let url: String
    }
    
    
    struct Results: Codable {
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
    }
   
}

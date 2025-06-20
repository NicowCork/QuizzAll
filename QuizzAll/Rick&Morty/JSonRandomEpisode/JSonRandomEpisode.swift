//
//  JSonRandomEpisode.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 18/04/2020.
//  Copyright © 2020 Nicolas Richard. All rights reserved.
//

import Foundation

struct JSonRandomEpisode: Codable {
    
    let info: Info
    let results: [Results]
    
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String
        let prev: String
    }
    
    struct Characters: Codable {
        let url: String
    }
    
    struct Results: Codable {
        let id: Int
        let name: String
        let airdate: String
        let characters: [Characters]
    }
}

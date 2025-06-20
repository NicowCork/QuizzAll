//
//  JSonSelectedEpisode.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 18/04/2020.
//  Copyright © 2020 Nicolas Richard. All rights reserved.
//

import Foundation

struct JSonSelectedEpisode: Codable {
    
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
}

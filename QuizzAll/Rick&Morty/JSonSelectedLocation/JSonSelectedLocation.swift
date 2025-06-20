//
//  JSonSelectedLocation.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 19/04/2020.
//  Copyright © 2020 Nicolas Richard. All rights reserved.
//

import Foundation

struct JSonSelectedLocation: Codable {
    
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}

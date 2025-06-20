//
//  JSonLocation.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 15/04/2020.
//  Copyright © 2020 Nicolas Richard. All rights reserved.
//

import Foundation

struct JSonLocation {
    
    let info: Info
    let results: [Results]
    
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String
        let prev: String
    }
    
    struct Results: Codable {
        
    }
}

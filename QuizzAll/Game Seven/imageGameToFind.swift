//
//  imageGameToFind.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 11/03/2020.
//  Copyright © 2020 Nicolas Richard. All rights reserved.
//

import Foundation
import UIKit


struct imageGameToFind {
    
    enum possibleArrowDirections {
        case up
        case down
    }
    enum possibleColors {
        case green
        case red
    }
    
    var arrowDirection: possibleArrowDirections?
    var colors: possibleColors?
    
}

//
//  Player_pallet.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 08/11/2019.
//  Copyright © 2019 Nicolas Richard. All rights reserved.
//

import Foundation

class PlayerSpace {
    
    var identifier: Int?
    var name: String?
    var niveau: Int?
    
    var numberOfJumpinARow: Int?
    var numberOfPalletLeft: Int?
   
    init(name: String) {
        self.name = name
    }
    
}

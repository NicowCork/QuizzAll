//
//  Pixel.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 01/11/2019.
//  Copyright © 2019 Nicolas Richard. All rights reserved.
//

import Foundation
import SpriteKit

class GameLogic {
    
    var _isGameOn: Bool
    var _numberOfPallets: Int
    var _totalWin: Int
    
    var _currentStreak: Int
    var _longestStreak: Int
 

    init() {
     
        self._isGameOn = false
        self._numberOfPallets = 4
        self._totalWin = 0
        self._currentStreak = 0
        self._longestStreak = 0
    }
  
    func ballLost() {
        _currentStreak = 0
        _numberOfPallets = _numberOfPallets - 1
    }
    
    
}

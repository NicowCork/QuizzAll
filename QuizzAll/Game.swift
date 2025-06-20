//
//  Game.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 03/05/2019.
//  Copyright © 2019 Nicolas Richard. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class Game: UIViewController {

    @IBOutlet var sk_view: SKView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
        
        if let skview = GameScene(fileNamed: "GameScene") {
            sk_view.presentScene(skview)            
        }
    }
}

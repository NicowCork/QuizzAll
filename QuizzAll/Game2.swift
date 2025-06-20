//
//  Game2.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 25/09/2019.
//  Copyright © 2019 Nicolas Richard. All rights reserved.
//

import Foundation
import SpriteKit

class Game2: UIViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet var sk_view2: SKView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
        
        if let skview2 = GameScene2(fileNamed: "GameScene2") {
            sk_view2.presentScene(skview2)
        }
    }
    
}

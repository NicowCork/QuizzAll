//
//  Game3.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 23/10/2019.
//  Copyright © 2019 Nicolas Richard. All rights reserved.
//

import Foundation
import SpriteKit

class Game3: UIViewController {

    @IBOutlet var sk_view3: SKView!
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
        
        if let skview3 = GameScene3(fileNamed: "GameScene3") {
            sk_view3.presentScene(skview3)
        }
    }
}

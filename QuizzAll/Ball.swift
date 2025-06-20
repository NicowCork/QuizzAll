//
//  Weed.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 10/10/2019.
//  Copyright © 2019 Nicolas Richard. All rights reserved.
//

import UIKit
import SpriteKit

class Ball: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "weed_head")
        let color = UIColor.clear
        let size = CGSize(width: 40, height: 80)

        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

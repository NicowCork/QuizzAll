//
//  Cop.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 09/10/2019.
//  Copyright © 2019 Nicolas Richard. All rights reserved.
//

import UIKit
import SpriteKit

class Cop: SKSpriteNode {
    init() {
        
        let texture = SKTexture(imageNamed: "game_policeman_clean")
        let color = UIColor.clear
        let size = CGSize(width: 40, height: 80)

        super.init(texture: texture, color: color, size: size)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func mooveCops() {
        self.position = CGPoint(x: -185, y: 300)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            self.physicsBody?.applyImpulse(CGVector(dx: 50, dy: -50))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1800)) {
            self.physicsBody?.applyImpulse(CGVector(dx: -70, dy: -30))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2400)) {
            self.physicsBody?.applyImpulse(CGVector(dx: 70, dy: -30))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(3000)) {
            self.physicsBody?.applyImpulse(CGVector(dx: -50, dy: -30))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(3600)) {
            self.physicsBody?.applyImpulse(CGVector(dx: 50, dy: -30))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(10000)) {
            self.physicsBody?.applyImpulse(CGVector(dx: -70, dy: -30))
        }
    }

}

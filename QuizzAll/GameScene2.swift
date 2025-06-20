//
//  GameScene2.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 25/09/2019.
//  Copyright © 2019 Nicolas Richard. All rights reserved.
//

  /*
   Objectiles = Weed
   Effet a l'impact = Fumée
   
   Enemies = Police
      Effet avant impact de weed = Label "Vive l'Etat"
      Effet apres impact de weed = Label "A bad l'Etat"
      Effet impact nul = MARAVE
   
   1 - S'occuper de l'angle de projection
   2 - Trouver une meilleur image Player
   3 - FAIT LE 2 AVANT
   */
      
import Foundation
import SpriteKit
import Foundation
import GameplayKit

class GameScene2: SKScene, SKPhysicsContactDelegate {
    override func didMove(to view: SKView) {
        let image_player = SKTexture(imageNamed: "game_2_gamer")
         
         DispatchQueue.main.async {
            self.nodeScore.text = "Score : \(self.scoreJoueur)"
            self.nodeScore.fontSize = 30
            self.nodeScore.fontColor = .red
            self.nodeScore.position = CGPoint(x: -130, y: -350)
            self.nodeScore.zPosition = 1
            self.addChild(self.nodeScore)
            
            self.ui_screen_background.position = CGPoint(x: 0, y: 0)
            self.ui_screen_background.size = CGSize(width: 414, height: 736)
            self.ui_screen_background.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
            self.ui_screen_background.physicsBody?.friction = 0
            self.ui_screen_background.physicsBody?.restitution = 1
            self.ui_screen_background.physicsBody?.isDynamic = false
            self.addChild(self.ui_screen_background)
             
            self.player.texture = image_player
            self.player.size = CGSize(width: 50, height: 50)
            self.player.position = CGPoint(x: 0, y: -20)
            self.player.physicsBody?.isDynamic = false
            self.player.physicsBody?.friction = 0
            self.addChild(self.player)
        }
        ui_screen_background.physicsBody?.categoryBitMask = categoryContact.categoryWall
        ui_screen_background.physicsBody?.contactTestBitMask = categoryContact.categoryWeed | categoryContact.categoryCop
        ui_screen_background.physicsBody?.collisionBitMask = categoryContact.categoryWeed | categoryContact.categoryCop
    
         physicsWorld.contactDelegate = self
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            zoneTouched = touch.location(in: self)
          if (touch.tapCount == 1) {
            tapWeed.append(1)
          }
        }
    }
    
    func processUserTaps(forUpdate currentTime: CFTimeInterval) {
        for tapCount in tapWeed {
            if tapCount == 1 {
                createSomeBalls()
                createSomeCop()
            }
            tapWeed.remove(at: 0)
        }
    }
    override func update(_ currentTime: TimeInterval) {
        processUserTaps(forUpdate: currentTime)
    }
    
    func createSomeBalls() {
        let ball: Ball = Ball()
        ball.position = CGPoint(x: 0, y: -20)
        addChild(ball)
        ball.physicsBody?.categoryBitMask = categoryContact.categoryWeed
        ball.physicsBody?.contactTestBitMask = categoryContact.categoryCop
        ball.physicsBody = SKPhysicsBody()
        ball.physicsBody?.applyForce(CGVector(dx: zoneTouched.x, dy: zoneTouched.y))
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
            ball.removeFromParent()
        }
    }
   
    func createSomeCop() {
        func random_respawn_cop() -> CGPoint {
            let random_x = Int.random(in: -155...155)
            let random_y = Int.random(in: 70...330)
            let position_cop = CGPoint(x: random_x, y: random_y)
            print("Position cop : \(position_cop)")
            return position_cop
        }
        let cop: Cop = Cop()
        let texture = SKTexture(imageNamed: "game_policeman_clean")
        addChild(cop)
        cop.physicsBody?.categoryBitMask = categoryContact.categoryCop
        cop.physicsBody?.contactTestBitMask = categoryContact.categoryWeed
        cop.physicsBody = SKPhysicsBody(texture: texture, size: CGSize(width: 40, height: 80))
        cop.physicsBody?.mass = 1
        cop.mooveCops()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(20)) {
            cop.removeFromParent()
        }
        
    }
 
    func didBegin(_ contact: SKPhysicsContact) {

        let firstBody = contact.bodyA.node
        let secondBody = contact.bodyB.node
        
        if firstBody?.physicsBody?.contactTestBitMask == categoryContact.categoryCop || firstBody?.physicsBody?.contactTestBitMask == categoryContact.categoryWeed {
            DispatchQueue.main.async {
                self.scoreJoueur += 1
                print("HIT")
                firstBody?.removeFromParent()
                secondBody?.removeFromParent()
            }
        }
    }
  
    struct categoryContact {
        static let categoryWeed: UInt32 = 0x1 << 1
        static let categoryCop: UInt32 = 0x1 << 2
        static let categoryWall: UInt32 = 0x1 << 3
    }
    
    var scoreJoueur: Int = 0 { didSet { nodeScore.text = "Score : \(self.scoreJoueur)"}}
    var zoneTouched = CGPoint() { didSet { print(zoneTouched)}}
    var tapWeed = [Int]()
    let ui_screen_background = SKSpriteNode()
    let player = SKSpriteNode()
    var nodeScore = SKLabelNode()
}

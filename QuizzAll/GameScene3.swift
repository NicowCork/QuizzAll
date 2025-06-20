//
//  GameScene3.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 23/10/2019.
//  Copyright © 2019 Nicolas Richard. All rights reserved.
//
// LIGNE 68 -> Trouver comment faire des virages.


import Foundation
import SpriteKit

class GameScene3: SKScene, SKPhysicsContactDelegate {
    
    let background = SKSpriteNode(imageNamed: "background_space")
    
    let WhiteParticle_1 = SKEmitterNode(fileNamed: "WhiteParticle_1")
    let ObjectParticle_01 = SKEmitterNode(fileNamed: "ObjectParticle_01")
    let ObjectParticle_02 = SKEmitterNode(fileNamed: "ObjectParticle_02")
    let ObjectParticle_03 = SKEmitterNode(fileNamed: "ObjectParticle_03")
    let ObjectParticle_04 = SKEmitterNode(fileNamed: "ObjectParticle_04")
    let ObjectParticle_05 = SKEmitterNode(fileNamed: "ObjectParticle_05")
    let ObjectParticle_06 = SKEmitterNode(fileNamed: "ObjectParticle_06")
    let ObjectParticle_07 = SKEmitterNode(fileNamed: "ObjectParticle_07")
    let ObjectParticleExplosion_01 = SKEmitterNode(fileNamed: "ObjectParticleExplosion_01")
    
    let nodeScorePlayer = SKLabelNode()
    let nodeLivesPlayer = SKLabelNode()
    let nodeButtonResetScore = SKSpriteNode()
    
    let spacePlayer = SKSpriteNode()
    
    var scorePlayer: Int = 0 { didSet { nodeScorePlayer.text = "\(scorePlayer)"} }
    var isSpaceTouched = false
    
    var timerFire = Timer()
    var timerTilts = Timer()
    var timerSpawnEnemies = Timer()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if let touch = touches.first {
            if spacePlayer.contains(touch.location(in: self)) {
                isSpaceTouched = true
                timerFire = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(fireLaserRed), userInfo: nil, repeats: true)
                timerFire.fire()
                print("fired!")
            }
            else {
                print("space not touched")
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (isSpaceTouched == true) {
            spacePlayer.position = (touches.first?.location(in: self))!
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSpaceTouched = false
        timerFire.invalidate()
    }
    override func didMove(to view: SKView) {
        setupBackground()
        setupPlayer()
        setupUI()
        physicsWorld.contactDelegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
            self.timerSpawnEnemies = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.spawnEnemies), userInfo: nil, repeats: true)
            self.timerSpawnEnemies.fire()
        }
    }
    
    @objc func spawnEnemies() {
        let texture = SKTexture(imageNamed: "enemyShip")
        let enemies = SKSpriteNode(texture: texture, size: CGSize(width: 100, height: 100))
        enemies.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100))
        enemies.physicsBody?.categoryBitMask = CategoryEnemies
        
        func random_respawn_enemies() -> CGPoint {
            let random_x = Int.random(in: -155...155)
            let random_y = Int.random(in: 70...330)
            let position_enemies = CGPoint(x: random_x, y: random_y)
            return position_enemies
        }
        
        enemies.zPosition = 1
        enemies.position = random_respawn_enemies()
        addChild(enemies)
        
    }
    
    @objc func makeVirages() {
        let actionTiltRight = SKAction.rotate(byAngle: .pi, duration: 1)
        WhiteParticle_1?.run(actionTiltRight)
    }
    
    @objc func fireLaserRed() {
        let texture = SKTexture(imageNamed: "laserRed")
        let fire = SKSpriteNode(texture: texture, size: CGSize(width: 15, height: 20))
        fire.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 27))
        fire.physicsBody?.categoryBitMask = CategoryFire
        fire.physicsBody?.contactTestBitMask = CategoryEnemies
        
        fire.position = CGPoint(x: spacePlayer.position.x, y:CGFloat((spacePlayer.position.y + 50)))
        fire.zPosition = 1
        
        fire.physicsBody?.isDynamic = true
        fire.physicsBody?.usesPreciseCollisionDetection = true
        fire.name = "fire"
        addChild(fire)
        fire.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 20))
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(900)) {
            fire.removeFromParent()
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
            print("1111")
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
            print("2222")
        }
        
        if (firstBody.categoryBitMask == CategoryFire && secondBody.categoryBitMask == CategoryEnemies) || (firstBody.categoryBitMask == CategoryEnemies && secondBody.categoryBitMask == CategoryFire) {
            firstBody.node?.removeFromParent()
            if let explosion = SKEmitterNode(fileNamed: "ObjectParticleExplosion_01") {
                explosion.position = contact.contactPoint
                addChild(explosion)
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                    secondBody.node?.removeFromParent()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
                    explosion.removeFromParent()
                }
            }
            scorePlayer += 1
            
        }
   
        
    }
    
    let CategoryFire: UInt32 = 0x1 << 1
    let CategoryEnemies: UInt32 = 0x1 << 2
      
    func setupBackground() {
        
        WhiteParticle_1?.position = CGPoint(x: 0, y: 1200)
        ObjectParticle_01?.position = CGPoint(x: 0, y: 1200)
        ObjectParticle_02?.position = CGPoint(x: 0, y: 1200)
        ObjectParticle_03?.position = CGPoint(x: 0, y: 1200)
        ObjectParticle_04?.position = CGPoint(x: 0, y: 1200)
        ObjectParticle_05?.position = CGPoint(x: 0, y: 1200)
        ObjectParticle_06?.position = CGPoint(x: 0, y: 1200)
        ObjectParticle_07?.position = CGPoint(x: 0, y: 1280)
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            
            self.addChild(self.background)
            self.addChild(self.WhiteParticle_1!)
            self.addChild(self.ObjectParticle_01!)
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                self.addChild(self.ObjectParticle_02!)
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1400)) {
                    self.addChild(self.ObjectParticle_03!)
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000)) {
                        self.addChild(self.ObjectParticle_04!)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2700)) {
                            self.addChild(self.ObjectParticle_05!)
                            DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(3600)) {
                                self.addChild(self.ObjectParticle_06!)
                                DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(4500)) {
                                                           self.addChild(self.ObjectParticle_07!)
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    }
    func setupPlayer() {
        let texturePlayer = SKTexture(imageNamed: "SpacePlayer")
        spacePlayer.zPosition = 1
        spacePlayer.texture = texturePlayer
        spacePlayer.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100))
        spacePlayer.position = CGPoint(x: 0, y: -310)
        spacePlayer.physicsBody?.affectedByGravity = false
        spacePlayer.size = CGSize(width: 100, height: 100)
        spacePlayer.physicsBody?.isDynamic = false
        spacePlayer.physicsBody?.friction = 0
        spacePlayer.name = "spacePlayer"
        addChild(spacePlayer)
    }
    
    func setupUI() {
        nodeScorePlayer.fontName = "Pixeled"
        nodeScorePlayer.position = CGPoint(x: -155, y: -344)
        nodeScorePlayer.fontSize = 20
        nodeScorePlayer.text = "000"
        nodeScorePlayer.zPosition = 1
        nodeScorePlayer.color = .green
        
        nodeLivesPlayer.fontName = "Pixeled"
        nodeLivesPlayer.position = CGPoint(x: 155, y: -344)
        nodeLivesPlayer.fontSize = 20
        nodeLivesPlayer.text = "000"
        nodeLivesPlayer.zPosition = 1
        nodeLivesPlayer.fontColor = .red
        
        addChild(nodeScorePlayer)
        addChild(nodeLivesPlayer)
        
    }
}


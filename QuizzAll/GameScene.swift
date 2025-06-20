//
//  GameScene.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 03/05/2019.
//  Copyright © 2019 Nicolas Richard. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var GameState: Int = 0
                                            // 0 = NewGameLaunchedFirst()
                                            // 1 = NewGameLaunched()
                                            // 2 = NewBall
                                            // 3 = isPlaying
                                            // 4 = BallLost
                                            // 5 = GameEnded
    func chooseGameState() {
        print("begin chooseGameState()")
        switch GameState {
        case 1: NewGameLaunched()
        case 2: NewBall()
        case 3: isPlaying()
        case 4: BallLost()
        case 5: GameEnded()
            
        default:
            break
        }
    }
    
    func NewGameLaunched() { //1
        print(GameState)
        
        p1.alpha = 1
        p2.alpha = 1
        
       
        print("arrive to newgamrelaunched!!! ")
        if let ui_score = childNode(withName: "ui_score") as? SKLabelNode {
            ui_score.alpha = 1
        }
        GameState = 2
        chooseGameState()
        
    }
    
    func NewBall() { //2
        print(GameState)
     
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            print("1111111111111")
            self.ball.alpha = 1
            self.ball.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
            print("222222222222")
        }
        print("33333333333")
        GameState = 3
        print(GameState)
        chooseGameState()
   
    }
    func isPlaying() { //3
        print(GameState)
      
    }
    func BallLost() { //4
        print("DIIIIIIIIIIIIIIIID IITTTTTTTTTT")
        ball.removeFromParent()
        addChild(ui_gameOver)
    }
    func GameEnded() { //5
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchbegan")
        
        let touch0 = touches.first
        let touchT0 = touch0!.location(in: self)
        
        if let bodyStart = physicsWorld.body(at: touchT0) {
                if bodyStart.node?.name == "ui_start" {
                    if GameState == 0 {
                        print("debutchoose1")
                        startTouched = true
                        ui_start.removeFromParent()
                    }
                }
        }
        if let body = physicsWorld.body(at: touchT0) {
            if body.node?.name == "ui_gameOver" && GameState == 4 {
                print("yeah")
                ui_gameOver.removeFromParent()
                addChild(ui_start)
                GameState = 0
                chooseGameState()
            }
            if body.node?.name == "p1" {
                fingerOnPaddle = true
            }
            if body.node?.name == "ball" {
                ball.physicsBody?.applyImpulse(CGVector(dx: 40, dy: 40))
            }
        }
    }
   
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
   
        if startTouched == true && GameState == 0 {
            print("choosegamestateafter startotuched()")
            GameState = 1
            chooseGameState()
        }
        
        if fingerOnPaddle == true && GameState == 3 {
            let touch = touches.first
            let touchLocation = touch!.location(in: self.view)
            let touchPrevious = touch?.previousLocation(in: self.view)
            let paddleX =  p1.position.x + (touchLocation.x - touchPrevious!.x)
            p1.position = CGPoint(x: paddleX, y: p1.position.y)
            p2.position = CGPoint(x: paddleX, y: p2.position.y)
        }
    }
    
    

    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
    //    if secondBody.categoryBitMask == topCategory || secondBody.categoryBitMask == bottomCategory {
    //        print("ahahahhaahahahahhhahahahahahahaah")
    //    }
        
        if firstBody.categoryBitMask == BallCategory {
            print("balll toucheeeeed")
            rebondsPalets += 1
            impulseBallRandom4()
            changeColorPixel()
        }
        if (ball.intersects(bottomLost) == true || ball.intersects(topLost) == true) && GameState == 3 {
            print("BALL SHOULD BE LOST")
            GameState = 4
            chooseGameState()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchended")
        fingerOnPaddle = false
        startTouched = false
    }
    
    override func sceneDidLoad() {
        print("scenedidload")
        
    }
   
    let BallCategory: UInt32 = 0x1 << 1
    let Palet1Category: UInt32 = 0x1 << 2
    let Palet2Category: UInt32 = 0x1 << 3
    let bottomCategory: UInt32 = 0x1 << 4
    let topCategory: UInt32 = 0x1 << 5
    
    let p1 = SKSpriteNode()
    let p2 = SKSpriteNode()
    let ball = SKSpriteNode()
    
    let bottomLost = SKSpriteNode()
    let topLost = SKSpriteNode()
    
    var ui_score = SKLabelNode()
    
    let ui_start = SKSpriteNode()
    let bg_pixel = SKSpriteNode()
    let ui_replay = SKSpriteNode()
    let ui_reset = SKSpriteNode()
    let ui_mainmenu = SKSpriteNode()
    let ui_bonus = SKSpriteNode()
    
    let ui_gameOver = SKSpriteNode()
    
    var startTouched: Bool = false
    var fingerOnPaddle: Bool = false
    var rebondsPalets: Int = 0 { didSet { ui_score.text = "\(rebondsPalets)" } }
    
    func impulseFromSide() {   // PAS ENCORE FINIS STAY STUCKED ON WALL BECAUSE IMPULSE dx40 dy40
        let min: Int = 1
        let max: Int = 5
        
        let randomImpulseSide = min + Int(arc4random_uniform(UInt32(max - min)))
        
        if randomImpulseSide == 1 {
            ball.physicsBody?.applyImpulse(CGVector(dx: 40, dy: 40))
        }
    }
    
    func impulseBallRandom4() {
        let min: Int = 1
        let max: Int = 10
        
        let randomImpulse = min + Int(arc4random_uniform(UInt32(max - min)))
        
        switch randomImpulse {
        case 1: ball.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 30))
        case 2: ball.physicsBody?.applyImpulse(CGVector(dx: -30, dy: 30))
        case 3: ball.physicsBody?.applyImpulse(CGVector(dx: 30, dy: -30))
        case 4: ball.physicsBody?.applyImpulse(CGVector(dx: -30, dy: -30))
        case 5: bonusWin50()
        default:
            break
        }
    }
    
    func bonusWin50() {
        rebondsPalets += 50
        ui_bonus.texture = SKTexture(imageNamed: "bonus_50")
        ui_score.fontColor = .red
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.ui_score.fontColor = .white
            self.ui_bonus.texture = nil
        }
    }
   
    func changeColorPixel() {
        
        let valeurMin: Int = 1
        let valeurMax: Int = 15
        
        let randomColor = valeurMin + Int(arc4random_uniform(UInt32(valeurMax - valeurMin)))
        
        switch randomColor {
            
        case 1: ball.color = .black
        case 2: ball.color = .blue
        case 3: ball.color = .brown
        case 5: ball.color = .cyan
        case 6: ball.color = .darkGray
        case 7: ball.color = .gray
        case 8: ball.color = .green
        case 9: ball.color = .lightGray
        case 10: ball.color = .magenta
        case 11: ball.color = .orange
        case 12: ball.color = .purple
        case 13: ball.color = .red
        case 14: ball.color = .white
        case 15: ball.color = .yellow
            
        default:
            break
        }
    }
    override func didMove(to view: SKView) {
        // w:414 h:736
        
        let texture_bg = SKTexture(imageNamed: "screen_multicolor_pixeliser1")
        let borderGame = SKPhysicsBody(edgeLoopFrom: CGRect(origin: CGPoint(x: -212, y: -350), size: CGSize(width: 414, height: 670)))
       // let texture_ball = SKTexture(imageNamed: "pixel")
        
        borderGame.friction = 0
        borderGame.restitution = 1
        self.physicsBody = borderGame
        
        bottomLost.position = CGPoint(x: 0, y: -335)
        bottomLost.size = CGSize(width: 414, height: 2)
        bottomLost.color = .black
        bottomLost.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 414, height: 2), center: bottomLost.position)
        bottomLost.physicsBody?.isDynamic = false
        bottomLost.alpha = 0
        
        topLost.position = CGPoint(x: 0, y: 305)
        topLost.size = CGSize(width: 414, height: 2)
        topLost.color = .black
        topLost.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 414, height: 2), center: topLost.position)
        topLost.physicsBody?.isDynamic = false
        topLost.alpha = 0
        
     
        p1.position = CGPoint(x: 0, y: -344)
        p1.size = CGSize(width: 120, height: 48)
        p1.alpha = 0
        p1.color = .red
        p1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 120, height: 48))
        p1.physicsBody?.friction = 0
        p1.physicsBody?.restitution = 1
        p1.physicsBody?.angularDamping = 0
        p1.physicsBody?.angularVelocity = 0
        p1.physicsBody?.isDynamic = false
        p1.name = "p1"
        
        p2.position = CGPoint(x: 0, y: 311)
        p2.size = CGSize(width: 120, height: 48)
        p2.alpha = 0
        p2.color = .red
        p2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 120, height: 48))
        p2.physicsBody?.friction = 0
        p2.physicsBody?.restitution = 1
        p2.physicsBody?.angularDamping = 0
        p2.physicsBody?.angularVelocity = 0
        p2.physicsBody?.isDynamic = false
        p2.name = "p2"
        
        ball.position = CGPoint(x: 0, y: 230)
        ball.size = CGSize(width: 50, height: 50)
        ball.alpha = 0
        ball.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        ball.color = .red
        ball.physicsBody?.friction = 0
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.allowsRotation = true
        ball.zPosition = 1
        ball.physicsBody?.isDynamic = true
        ball.name = "ball"
        
        bg_pixel.texture = texture_bg
        bg_pixel.position = CGPoint(x: 0, y: 0)
        bg_pixel.size = CGSize(width: 414, height: 736)
        bg_pixel.physicsBody?.friction = 0
        bg_pixel.physicsBody?.restitution = 1
        
        ui_reset.texture = SKTexture(imageNamed: "ui_reset")
        ui_reset.position = CGPoint(x: 150, y: 368)
        ui_reset.size = CGSize(width: 110, height: 50)
        ui_reset.physicsBody?.restitution = 1
        ui_reset.physicsBody?.friction = 0
        ui_reset.name = "reset"
        ui_reset.physicsBody = SKPhysicsBody(rectangleOf: ui_reset.size)
       
        ui_mainmenu.texture = SKTexture(imageNamed: "ui_mainmenu")
        ui_mainmenu.position = CGPoint(x: -155, y: 356)
        ui_mainmenu.size = CGSize(width: 100, height: 20)
        ui_mainmenu.physicsBody?.restitution = 1
        ui_mainmenu.physicsBody?.friction = 0
        ui_mainmenu.name = "mainmenu"
        
        ui_start.position = CGPoint(x: 0, y: 0)
        ui_start.texture = SKTexture(imageNamed: "ui_start")
        ui_start.size = CGSize(width: 330, height: 146)
        ui_start.name = "ui_start"
        ui_start.physicsBody?.friction = 0
        ui_start.physicsBody?.restitution = 1
        ui_start.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 330, height: 146))
        
        ui_gameOver.position = CGPoint(x: 0, y: 0)
        ui_gameOver.texture = SKTexture(imageNamed: "ui_gameover")
        ui_gameOver.size = CGSize(width: 330, height: 146)
        ui_gameOver.name = "ui_gameOver"
        ui_gameOver.physicsBody = SKPhysicsBody(rectangleOf: ui_gameOver.size)
        
        ui_score.position = CGPoint(x: 63, y: 339)
        ui_score.fontName = "Pixeled"
        ui_score.physicsBody?.friction = 0
        ui_score.physicsBody?.restitution = 1
        ui_score.fontSize = 20
        ui_score.text = "0"
        
        ui_bonus.position = CGPoint(x: -46, y: 351)
        ui_bonus.size = CGSize(width: 100, height: 25)
        ui_bonus.name = "ui_bonus"
        ui_bonus.physicsBody?.restitution = 1
        ui_bonus.physicsBody?.friction = 0
        
        ball.physicsBody?.categoryBitMask = BallCategory
        p1.physicsBody?.categoryBitMask = Palet1Category
        p2.physicsBody?.categoryBitMask = Palet2Category
        
        ball.physicsBody?.contactTestBitMask = Palet1Category | Palet2Category
        
        addChild(ball)
        addChild(bg_pixel)
        addChild(ui_reset)
        addChild(ui_mainmenu)
        addChild(p1)
        addChild(p2)
        addChild(ui_score)
        addChild(ui_start)
        addChild(ui_bonus)
        addChild(bottomLost)
        addChild(topLost)
        
        chooseGameState()
        physicsWorld.contactDelegate = self
        
    }
}

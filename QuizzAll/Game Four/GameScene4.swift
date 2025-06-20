//
//  GameScene4.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 30/10/2019.
//  Copyright © 2019 Nicolas Richard. All rights reserved.
//

import Foundation
import SpriteKit

// TODO:
// 1 - Trouver le Model pour le score
// 2 - Modifier l'UI
// 3 - MVC


class GameScene4: SKScene, SKPhysicsContactDelegate {
    
    let menuGo = SKLabelNode()
    let menuNewBall = SKLabelNode()
    var bonusMessageLabel = SKLabelNode()
    
    let nd_background = SKSpriteNode(imageNamed: "background_space")
    let actionSoundJump = SKAction.playSoundFileNamed("ball_hit_ground", waitForCompletion: true)
    let actionSoundWin = SKAction.playSoundFileNamed("sound_win", waitForCompletion: true)
    let actionSoundLost = SKAction.playSoundFileNamed("sound_lost", waitForCompletion: true)

    let pallet = SKSpriteNode(imageNamed: "pallet")
    
    let pallet_4 = SKSpriteNode(imageNamed: "pallet")
    let pallet_3 = SKSpriteNode(imageNamed: "pallet")
    let pallet_2 = SKSpriteNode(imageNamed: "pallet")
    let pallet_1 = SKSpriteNode(imageNamed: "pallet")
    
    let PalletParticle = SKEmitterNode(fileNamed: "PalletParticle")
    let BackGroundParticle = SKEmitterNode(fileNamed: "BackgroundGame_stars")
    
    let scoreWin = SKLabelNode()
    
    let ui_currentStreak = SKLabelNode()
    let ui_bestStreak = SKLabelNode()
    let ui_totalScore = SKLabelNode()
    
    let button_volume = SKLabelNode()
    let button_reset = SKLabelNode()
    
    var edgeWin = SKSpriteNode()
    var edgeLoose = SKSpriteNode()
    
    var timerBalls0 = Timer()
    var timerBalls5 = Timer()
    var timerBalls10 = Timer()
    var timerBalls15 = Timer()
    var timerBalls20 = Timer()
    var timerBalls25 = Timer()
    var timerBalls30 = Timer()
    var timerBalls35 = Timer()
    
    var timerDeleteBalls = Timer()

    var isRunning: Bool = false
    var isSoundOn = true
    
    func invalidateAllTimers() {
        timerBalls0.invalidate()
        timerBalls5.invalidate()
        timerBalls10.invalidate()
        timerBalls15.invalidate()
        timerBalls20.invalidate()
        timerBalls25.invalidate()
        timerBalls30.invalidate()
        timerBalls35.invalidate()
    }
    
    func modifyTimerAccordingToLevelUp(lvlUp: Int) {
        switch lvlUp {
        case 5:
            invalidateAllTimers()
            timerBalls5 = Timer.scheduledTimer(timeInterval: 3.00, target: self, selector: #selector(addSomeBalls), userInfo: nil, repeats: true)
            timerBalls5.fire()
            print("lvl up 5")
        case 10:
            invalidateAllTimers()
            timerBalls10 = Timer.scheduledTimer(timeInterval: 2.66, target: self, selector: #selector(addSomeBalls), userInfo: nil, repeats: true)
            timerBalls10.fire()
            print("lvl up 10")
        case 15:
            invalidateAllTimers()
            timerBalls15 = Timer.scheduledTimer(timeInterval: 2.33, target: self, selector: #selector(addSomeBalls), userInfo: nil, repeats: true)
            timerBalls15.fire()
            print("lvl up 15")
        case 20:
            invalidateAllTimers()
            timerBalls20 = Timer.scheduledTimer(timeInterval: 2.00, target: self, selector: #selector(addSomeBalls), userInfo: nil, repeats: true)
            timerBalls20.fire()
        case 25:
            invalidateAllTimers()
            timerBalls25 = Timer.scheduledTimer(timeInterval: 1.66, target: self, selector: #selector(addSomeBalls), userInfo: nil, repeats: true)
            timerBalls25.fire()
        case 30:
            invalidateAllTimers()
            timerBalls30 = Timer.scheduledTimer(timeInterval: 1.33, target: self, selector: #selector(addSomeBalls), userInfo: nil, repeats: true)
            timerBalls30.fire()
        case 35:
            invalidateAllTimers()
            timerBalls35 = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: #selector(addSomeBalls), userInfo: nil, repeats: true)
            timerBalls35.fire()
            
        default:
            print("No modifyTimerAccordingToLevelUp to do")
        }
    }
    
    func setupTimerForScore() {
        
        switch ballsWon {
        case 0..<5:
            timerBalls0 = Timer.scheduledTimer(timeInterval: 3.33, target: self, selector: #selector(addSomeBalls), userInfo: nil, repeats: true)
            timerBalls0.fire()
            print("0..<5")
        case 5..<10:
            timerBalls5 = Timer.scheduledTimer(timeInterval: 3.00, target: self, selector: #selector(addSomeBalls), userInfo: nil, repeats: true)
            timerBalls5.fire()
            print("5..<10")
        case 10..<15:
            timerBalls10 = Timer.scheduledTimer(timeInterval: 2.66, target: self, selector: #selector(addSomeBalls), userInfo: nil, repeats: true)
            timerBalls10.fire()
            print("10..<15")
        case 15..<20:
            timerBalls15 = Timer.scheduledTimer(timeInterval: 2.33, target: self, selector: #selector(addSomeBalls), userInfo: nil, repeats: true)
            timerBalls15.fire()
            print("15..<20")
        case 20..<25:
            timerBalls20 = Timer.scheduledTimer(timeInterval: 2.00, target: self, selector: #selector(addSomeBalls), userInfo: nil, repeats: true)
            timerBalls20.fire()
            print("20..<25")
        case 25..<30:
            timerBalls25 = Timer.scheduledTimer(timeInterval: 1.66, target: self, selector: #selector(addSomeBalls), userInfo: nil, repeats: true)
            timerBalls25.fire()
            print("25..<30")
        case 30..<35:
            timerBalls30 = Timer.scheduledTimer(timeInterval: 1.33, target: self, selector: #selector(addSomeBalls), userInfo: nil, repeats: true)
            timerBalls30.fire()
            print("30..<35")
        case 35...:
            timerBalls35 = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: #selector(addSomeBalls), userInfo: nil, repeats: true)
            timerBalls35.fire()
        default:
            print("too much balls won")
        }
    }
    
    func newBall() {
        pallet.addChild(PalletParticle!)
        print("newBall")
        if let particlemenugo = childNode(withName: "MenuLostBall") {
            particlemenugo.removeFromParent()
        }
        setupTimerForScore()
        menuNewBall.removeFromParent()
    
    }
    
    func displayMenuBallLost() {
        if let particlemenugo = SKEmitterNode(fileNamed: "MenuLostBall") {
            particlemenugo.name = "MenuLostBall"
            addChild(particlemenugo)
        }
        print("display menu ball lost")
        addChild(menuNewBall)
    }

    func ballLost() {
        
        pallet.removeAllChildren()
        invalidateAllTimers()
        timerDeleteBalls = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(deleteAllBalls), userInfo: nil, repeats: true)
        timerDeleteBalls.fire()
        displayMenuBallLost()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.timerDeleteBalls.invalidate()
        }
        
        print("ballLost")
        ballsLost += 1
        currentStreakInt = 0
    }
    
    func gameOver() {
        print("gameover ?")
        invalidateAllTimers()
        self.isUserInteractionEnabled = false
    }
    
    var bestStreakInt:Int = 0 {
        didSet {
            ui_bestStreak.text = "\(bestStreakInt)"
        }
    }
    var currentStreakInt: Int = 0 {
        didSet {
            ui_currentStreak.text = "\(currentStreakInt)"
        }
    }
    
    var totalScore: Int = 0 {
        didSet {
            ui_totalScore.text = "\(totalScore)"
        }
    }
    
    func calculateTotalScore() {
        totalScore = bestStreakInt * ballsWon
    }
    
    var ballsLost: Int = 0 {
        didSet {
            switch self.ballsLost {
            case 0:
                print("game just began")
            case 1:
                self.pallet_1.removeFromParent()
            case 2:
                self.pallet_2.removeFromParent()
            case 3:
                self.pallet_3.removeFromParent()
            case 4:
                self.pallet_4.removeFromParent()
            case 5:
                gameOver()
            default:
                print("default")
            }
        }
    }
    
    var ballsWon:Int = 0 {
        didSet {
            scoreWin.text = "SCORE \(ballsWon)"
            displayTheBonusMessage(numberLevel: self.ballsWon)
            modifyTimerAccordingToLevelUp(lvlUp: self.ballsWon)
            handlePalletParticle(withLvl: self.ballsWon)
        }
    }
    
    
    func handlePalletParticle(withLvl lvl: Int) {
        switch lvl {
        case ...2:
            PalletParticle?.particleBirthRate = 30
        case 3...6:
            PalletParticle?.particleBirthRate = 60
        case 7...10:
            PalletParticle?.particleBirthRate = 120
        case 11...20:
            PalletParticle?.particleBirthRate = 150
        case 30...:
            PalletParticle?.particleBirthRate = 200
        default:
            print("ADWefsdgrf")
        }
    }
    
    
    func displayTheBonusMessage(numberLevel: Int) {
        let actionWait = SKAction.wait(forDuration: 1)
        let actionFade = SKAction.fadeOut(withDuration: 1)
        let actionRemoove = SKAction.removeFromParent()
        
        let sequenceBonus = SKAction.sequence([actionWait, actionFade, actionRemoove])
        
        switch numberLevel {
        case 0:
            print("0 LOL")
            bonusMessageLabel.text = "LEVEL 1"
            addChild(bonusMessageLabel)
            bonusMessageLabel.run(sequenceBonus)
        case 5:
            print("5 LOL")
            bonusMessageLabel.alpha = 1
            bonusMessageLabel.text = "LEVEL 2"
            addChild(bonusMessageLabel)
            bonusMessageLabel.run(sequenceBonus)
        case 10:
            print("10 LOL")
            bonusMessageLabel.alpha = 1
            bonusMessageLabel.text = "LEVEL 3"
            addChild(bonusMessageLabel)
            bonusMessageLabel.run(sequenceBonus)
        case 15:
            bonusMessageLabel.alpha = 1
            bonusMessageLabel.text = "LEVEL 4"
            addChild(bonusMessageLabel)
            bonusMessageLabel.run(sequenceBonus)
        case 20:
            bonusMessageLabel.alpha = 1
            bonusMessageLabel.text = "LEVEL 5"
            addChild(bonusMessageLabel)
            bonusMessageLabel.run(sequenceBonus)
        case 25:
            bonusMessageLabel.alpha = 1
            bonusMessageLabel.text = "LEVEL 6"
            addChild(bonusMessageLabel)
            bonusMessageLabel.run(sequenceBonus)
        case 30:
            bonusMessageLabel.alpha = 1
            bonusMessageLabel.text = "LEVEL 6"
            addChild(bonusMessageLabel)
            bonusMessageLabel.run(sequenceBonus)
        case 35...:
            bonusMessageLabel.alpha = 1
            bonusMessageLabel.text = "LEVEL MAX DUCON"
            addChild(bonusMessageLabel)
            bonusMessageLabel.run(sequenceBonus)
        
        default:
            print("No bonusm message")
        }
    }
    
    struct positionsPallets {
         let positionLeft = CGPoint(x: -140, y:-335)
         let positionMiddle = CGPoint(x: 0, y: -335)
         let positionRight = CGPoint(x: 140, y: -335)
     }
    
    struct categoryPhysics {
        let borderScreen: UInt32 = 0x1 << 1
        let balls: UInt32 = 0x1 << 2
        let pallet: UInt32 = 0x1 << 3
        let edgeWin: UInt32 = 0x1 << 4
        let edgeLoose: UInt32 = 0x1 << 5
    }
  
   
//
    
    func didBegin(_ contact: SKPhysicsContact) {
        let first = contact.bodyA
        let second = contact.bodyB

        
        // si une ball est perdue
        if second.categoryBitMask == categoryPhysics.init().balls && first.categoryBitMask == categoryPhysics.init().edgeLoose {
            ballLost()
            
            if isSoundOn == true {
                run(actionSoundLost)
            } else {
                print("cant play sound")
            }
            
            if let explosion_lost = SKEmitterNode(fileNamed: "BallLost") {
                let position_node_lost = CGPoint(x: (second.node?.position.x)!, y: (second.node?.position.y)!)
                second.node?.removeFromParent()
                explosion_lost.position = CGPoint(x: position_node_lost.x, y: position_node_lost.y)
                addChild(explosion_lost)
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                    explosion_lost.removeFromParent()
                }
            }
        }
        
        // si une balle touche un pallet
        if second.categoryBitMask == categoryPhysics.init().balls && first.categoryBitMask == categoryPhysics.init().pallet {
                bestStreakInt += 1
                currentStreakInt += 1
                calculateTotalScore()
            
                if isSoundOn == true {
                    run(actionSoundJump)
                } else {
                        print("cant play sound")
                }
        }
        
        // si une ball arrive de lautre cote
        if second.categoryBitMask == categoryPhysics.init().balls && first.categoryBitMask == categoryPhysics.init().edgeWin {
            
            calculateTotalScore()
            ballsWon += 1
//
            if isSoundOn == true {
                run(actionSoundWin)
            } else {
                print("cant play sound")
            }
 
            if let explosion_win = SKEmitterNode(fileNamed: "BallsWinParticle") {
                let position_node_win = CGPoint(x: (second.node?.position.x)!, y: (second.node?.position.y)!)
                second.node?.removeFromParent()
                explosion_win.position = CGPoint(x: position_node_win.x, y: position_node_win.y)
                addChild(explosion_win)
                
                let action1 = SKAction.scale(to: 1.7, duration: 0.2)
                let action2 = SKAction.scale(to: 0.8, duration: 0.5)
                let action3 = SKAction.fadeAlpha(to: 0, duration: 0.4)
                let action4 = SKAction.removeFromParent()
            
                let actions_balls_win = SKAction.sequence([action1, action2, action3, action4])
                explosion_win.run(actions_balls_win)
                
            }
        }
        
    }
  
    override func didMove(to view: SKView) {
        self.view?.showsNodeCount = true
        self.view?.showsFPS = true
        self.physicsWorld.gravity.dy = -4
        
        setupGame()
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: CGPoint(x: -480, y: -800), size: CGSize(width: 960, height: 1600)))
        physicsWorld.contactDelegate = self
        self.physicsBody?.categoryBitMask = categoryPhysics.init().borderScreen
        self.physicsBody?.contactTestBitMask = categoryPhysics.init().balls
        
    }
    
    @objc func deleteAllBalls() {

        self.enumerateChildNodes(withName: "ball") {
               node, stop in
            node.run(SKAction.removeFromParent())
            print("running deleteballs")
        }
        self.enumerateChildNodes(withName: "Spawn_ball") {
               node, stop in
            node.run(SKAction.removeFromParent())
            print("running deletespawnballs")
        }
        
    }
 
    @objc func addSomeBalls() {
        func randomPosition() -> CGPoint {
            let positions: [CGPoint] = [CGPoint(x: -210, y: 75), CGPoint(x: -210, y: 115)]
            return positions.randomElement()!
        }
        func randomImpulse() -> CGVector {
            let vectors: [CGVector] = [CGVector(dx: 4.5, dy: 2), CGVector(dx: 3, dy: 2)]
            return vectors.randomElement()!
        }
        let ball = createABall()
        ball.position = randomPosition()
        
        let positionForWhite: CGPoint = CGPoint(x: (ball.position.x - 30), y: ball.position.y)
        
        if let Spawn_ball = SKEmitterNode(fileNamed: "Spawn_ball") {
            Spawn_ball.position = positionForWhite
            addChild(Spawn_ball)
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1900)) {
                Spawn_ball.removeFromParent()
            }
        }
        
        if let smallBalls = SKEmitterNode(fileNamed: "FinalBalls") {
            ball.addChild(smallBalls)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000)) {
            ball.physicsBody?.isDynamic = true
            self.addChild(ball)
            ball.physicsBody?.applyImpulse(randomImpulse())
        }
    }
    
    
    func createABall() -> SKShapeNode {
        let ball = SKShapeNode(circleOfRadius: 15)
        ball.name = "ball"
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 15)
        ball.physicsBody?.isDynamic = false
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.allowsRotation = true
        ball.physicsBody?.categoryBitMask = categoryPhysics.init().balls
        ball.physicsBody?.contactTestBitMask = categoryPhysics.init().borderScreen
        ball.physicsBody?.collisionBitMask = categoryPhysics.init().pallet
        
        switch Int.random(in: 0...2) {
        case 0: ball.fillColor = #colorLiteral(red: 0.2470588235, green: 0.368627451, blue: 0.9843137255, alpha: 1)
        case 1: ball.fillColor = #colorLiteral(red: 0.7215686275, green: 0.3098039216, blue: 0.6235294118, alpha: 1)
        case 2: ball.fillColor = #colorLiteral(red: 0.9882352941, green: 0.2745098039, blue: 0.4196078431, alpha: 1)
        default:
            print("no color to fill with")
        }
        
        return ball
    }
    // MARK: adssdf
    
    func transformMenu() {
        
        let actionRun = SKAction.run {
            self.isRunning = true
            if let nodeMenu = self.childNode(withName: "menuGo") as! SKLabelNode? {
                nodeMenu.fontSize = 50
                nodeMenu.text = "3"
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                    nodeMenu.text = "2"
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    nodeMenu.text = "1"
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                    nodeMenu.text = "Go"
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
                    nodeMenu.removeFromParent()
                    self.newBall()
                    self.displayTheBonusMessage(numberLevel: 0)
                }
            }
        }
        if isRunning == true {
            print("its running")
        } else {
            run(actionRun)
        }
    }
    
    // MARK: adsf
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touch01 = touch?.location(in: self)
        
        if let node_menu = physicsWorld.body(at: touch01!) {
            if node_menu.node?.name == "menuGo" {
                transformMenu()
            }
        }
        
        if let node_main_menu = physicsWorld.body(at: touch01!) {
            if node_main_menu.node?.name == "button_reset" {
                print("should reset the game")
            }
        }
        
        if let node_menu_ball_lost = physicsWorld.body(at: touch01!) {
            if node_menu_ball_lost.node?.name == "menuNewBall" {
                newBall()
            }
        }
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
            if touch01!.x < 0 {
                self.palletMooveToLeft()
            } else {
                self.palletMooveToRight()
            }
        }
    }
    
    func palletMooveToLeft() {
        
        let actionMiddleLeft = SKAction.moveTo(x: positionsPallets.init().positionLeft.x, duration: 0.05)
        let actionRightMiddle = SKAction.moveTo(x: positionsPallets.init().positionMiddle.x, duration: 0.05)
        
        if pallet.position == positionsPallets.init().positionMiddle {
            pallet.run(actionMiddleLeft)
        } else if pallet.position == positionsPallets.init().positionRight {
            pallet.run(actionRightMiddle)
        }
    }
    
    func palletMooveToRight() {
        
        let actionMiddleRight = SKAction.moveTo(x: positionsPallets.init().positionRight.x, duration: 0.05)
        let actionLeftMiddle = SKAction.moveTo(x: positionsPallets.init().positionMiddle.x, duration: 0.05)
        
        if pallet.position == positionsPallets.init().positionMiddle {
            pallet.run(actionMiddleRight)
        } else if pallet.position == positionsPallets.init().positionLeft {
            pallet.run(actionLeftMiddle)
        }
    }
    
    func setupGame() {
        
        if let edgeright = SKEmitterNode(fileNamed: "EdgeRight"),
            let edgeLeft = SKEmitterNode(fileNamed: "EdgeLeft") {
            edgeright.position = CGPoint(x: 72, y: -350)
            edgeright.particleSize = CGSize(width: 25, height: 25)
            edgeLeft.position = CGPoint(x: -72, y: -350)
            edgeLeft.particleSize = CGSize(width: 25, height: 25)
        
            let actionRightUp = SKAction.move(to: CGPoint(x: 72, y: -220), duration: 2)
            let actionRightDown = SKAction.move(to: CGPoint(x: 72, y: -300), duration: 1)
            
            let actionLeftUp = SKAction.move(to: CGPoint(x: -72, y: -220), duration: 1)
            let actionLeftDown = SKAction.move(to: CGPoint(x: -72, y: -300), duration: 2)
            
            let actionR = SKAction.sequence([actionRightUp, actionRightDown])
            let actionL = SKAction.sequence([actionLeftUp, actionLeftDown])
            
            edgeright.run(SKAction.repeatForever(actionR))
            edgeLeft.run(SKAction.repeatForever(actionL))
            
            addChild(edgeLeft)
            addChild(edgeright)
        }
        
        
        pallet_3.size = CGSize(width: 80, height: 17)
        pallet_3.position = CGPoint(x: -155, y: 295)
        
        pallet_4.size = CGSize(width: 80, height: 17)
        pallet_4.position =  CGPoint(x: -155, y: 320)
        
        pallet_2.size = CGSize(width: 80, height: 17)
        pallet_2.position = CGPoint(x: -65, y: 320)
        
        pallet_1.size = CGSize(width: 80, height: 17)
        pallet_1.position = CGPoint(x: -65, y: 295)
        
        
        pallet.size = CGSize(width: 155, height: 30)
        pallet.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 155, height: 30))
        pallet.physicsBody?.restitution = 1
        pallet.physicsBody?.isDynamic = false
        pallet.position = positionsPallets.init().positionMiddle
        
        pallet.physicsBody?.categoryBitMask = categoryPhysics.init().pallet
        pallet.physicsBody?.contactTestBitMask = categoryPhysics.init().balls
 
        button_reset.text = "🚀"
        button_reset.position = CGPoint(x: 155, y: 300)
        button_reset.name = "button_reset"
        button_reset.fontSize = 40
        button_reset.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        button_reset.physicsBody?.isDynamic = false
        
        ui_currentStreak.fontName = "Pixeled"
        ui_currentStreak.position = CGPoint(x: 0, y: 200)
        ui_currentStreak.fontColor = .systemOrange
        ui_currentStreak.fontSize = 16
        ui_currentStreak.text = "0"
        
        ui_bestStreak.fontName = "Pixeled"
        ui_bestStreak.position = CGPoint(x: 0, y: 250)
        ui_bestStreak.fontColor = .systemOrange
        ui_bestStreak.fontSize = 22
        ui_bestStreak.text = "0"
        
        ui_totalScore.fontName = "Pixeled"
        ui_totalScore.position = CGPoint(x: 120, y: 250)
        ui_totalScore.fontColor = .systemTeal
        ui_totalScore.fontSize = 22
        ui_bestStreak.text = "0"
        
        scoreWin.fontName = "Pixeled"
        scoreWin.fontColor = .green
        scoreWin.fontSize = 20
        scoreWin.position = CGPoint(x: 50, y: 301)
        scoreWin.text = "SCORE 0"
        
        bonusMessageLabel.position = CGPoint(x: 0, y: 150)
        bonusMessageLabel.fontSize = 25
        bonusMessageLabel.fontName = "Pixeled"
        
        menuNewBall.text = "GO !"
        menuNewBall.fontColor = .red
        menuNewBall.fontName = "Pixeled"
        menuNewBall.position = CGPoint(x: 0, y: 0)
        menuNewBall.fontSize = 60
        menuNewBall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 300, height: 100))
        menuNewBall.physicsBody?.isDynamic = false
        menuNewBall.name = "menuNewBall"
        
        menuGo.text = "Appuies pour commencer"
        menuGo.fontColor = .red
        menuGo.fontName = "Pixeled"
        menuGo.position = CGPoint(x: 0, y: 0)
        menuGo.zPosition = 1
        menuGo.fontSize = 17
        menuGo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 300, height: 100))
        menuGo.physicsBody?.isDynamic = false
        menuGo.name = "menuGo"
        
        edgeLoose.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: CGPoint(x: -200, y: -370), size: CGSize(width: 400, height: 20)))
        edgeLoose.physicsBody?.isDynamic = false
        edgeLoose.physicsBody?.affectedByGravity = false
        edgeLoose.physicsBody?.categoryBitMask = categoryPhysics.init().edgeLoose
        edgeLoose.physicsBody?.contactTestBitMask = categoryPhysics.init().balls
        
        edgeWin.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: CGPoint(x: 210, y: -670), size: CGSize(width: 20, height: 1340)))
        edgeWin.physicsBody?.isDynamic = false
        edgeWin.physicsBody?.affectedByGravity = false
        edgeWin.physicsBody?.categoryBitMask = categoryPhysics.init().edgeWin
        edgeWin.physicsBody?.contactTestBitMask = categoryPhysics.init().balls
        
        addChild(edgeWin)
        addChild(edgeLoose)
        
        addChild(nd_background)
        addChild(pallet)
        addChild(pallet_4)
        addChild(pallet_3)
        addChild(pallet_2)
        addChild(pallet_1)
        addChild(menuGo)
        
        addChild(scoreWin)
        
        addChild(ui_currentStreak)
        addChild(ui_bestStreak)
        addChild(ui_totalScore)
        
        addChild(button_reset)
    }
    
}

//    func animeStreak() {
//
////        let actionUp = SKAction.run {
////            self.scoreStreakNumber.fontSize = self.scoreStreakNumber.fontSize * 2
////        }
////
////        let actionWait = SKAction.wait(forDuration: 0.4)
////
////        let actonDown = SKAction.run {
////            self.scoreStreakNumber.fontSize = self.scoreStreakNumber.fontSize / 2
////        }
////
////        let actionSS = SKAction.sequence([actionUp, actionWait, actonDown])
//
//        switch currentStreakInt {
//        case 0:
//            score_niveau.text = "NIVEAU BLOB"
////            scoreStreakNumber.fontSize = 14
//            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
//                self.timerBallsOne = Timer.scheduledTimer(timeInterval: 4.63, target: self, selector: #selector(self.addSomeBalls), userInfo: nil, repeats: true)
//                self.timerBallsOne.fire()
//            }
//
//        case 1..<10:
//            print("1..10")
////            scoreStreakNumber.fontSize = 17
//        case 10:
//            score_niveau.text = "NIVEAU 1"
////            scoreStreakNumber.run(actionSS)
//            timerBallsOne.invalidate()
//            timerBallsTwo = Timer.scheduledTimer(timeInterval: 3.63, target: self, selector: #selector(addSomeBalls), userInfo: nil, repeats: true)
//            timerBallsTwo.fire()
//        case 11..<20:
//            print("11..20")
////            scoreStreakNumber.fontSize = 20
//        case 20:
//            score_niveau.text = "NIVEAU 2"
////            scoreStreakNumber.run(actionSS)
//            timerBallsTwo.invalidate()
//            timerBallsThree = Timer.scheduledTimer(timeInterval: 3.54, target: self, selector: #selector(addSomeBalls), userInfo: nil, repeats: true)
//            timerBallsThree.fire()
//        case 21..<30:
//            print("11..30")
////            scoreStreakNumber.fontSize = 23
//        case 30:
//            score_niveau.text = "NIVEAU 3"
////            scoreStreakNumber.run(actionSS)
//            timerBallsThree.invalidate()
//            timerBallsFour = Timer.scheduledTimer(timeInterval: 2.61, target: self, selector: #selector(addSomeBalls), userInfo: nil, repeats: true)
//            timerBallsFour.fire()
//        case 31..<40:
//              print("31..40")
////            scoreStreakNumber.fontSize = 26
//        case 40:
//            score_niveau.text = "NIVEAU 4"
////            scoreStreakNumber.run(actionSS)
//            timerBallsThree.invalidate()
//            timerBallsFour = Timer.scheduledTimer(timeInterval: 1.37, target: self, selector: #selector(addSomeBalls), userInfo: nil, repeats: true)
//            timerBallsFour.fire()
//        case 41...:
//            print("case 41....")
////            scoreStreakNumber.fontSize = 30
//        default:
//            print("default case again")
//        }
//    }

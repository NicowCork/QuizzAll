//
//  GameSevenVC.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 11/02/2020.
//  Copyright © 2020 Nicolas Richard. All rights reserved.
//

import UIKit
import Foundation

class GameSevenVC: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameViewRecognizer()
    }
    
//MARK: FUNC VIEW & ANIMATE & GESTURES
    
    func setupGameViewRecognizer() {

        let swipeRecognizerUp = UISwipeGestureRecognizer(target: self, action: #selector(handlingSwipes(recognizer:)))
        swipeRecognizerUp.direction = .up
        let swipeRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(handlingSwipes(recognizer:)))
        swipeRecognizerDown.direction = .down
        let swipeRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(handlingSwipes(recognizer:)))
        swipeRecognizerRight.direction = .right
        let swipeRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(handlingSwipes(recognizer:)))
        swipeRecognizerLeft.direction = .left

        uiview_game.addGestureRecognizer(swipeRecognizerUp)
        uiview_game.addGestureRecognizer(swipeRecognizerDown)
        uiview_game.addGestureRecognizer(swipeRecognizerRight)
        uiview_game.addGestureRecognizer(swipeRecognizerLeft)
    }
    
    func animateTheView(withView viewIntern: UIView) {
        
        viewIntern.alpha = 0
       
        UIView.animate(withDuration: modelRules.delayBetweenTwoCard , delay: 0, options: [], animations: {
            viewIntern.alpha = 1
            
        }) { (true) in
            
            viewIntern.alpha = 0
            self.uil_announce.text = " "
        }
    }
    
    func animateNewGameButtonOulet() {
    
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
            self.newGameButtonOutlet.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (true) in
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.8, options: [], animations: {
                self.newGameButtonOutlet.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }) { (true) in
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseOut], animations: {
                    self.newGameButtonOutlet.transform = .identity
                }) { (true) in
                    self.animateMenuAnnounce()
                }
            }
        }
    }
    func animateMenuAnnounce() {
    
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
            self.uil_announce.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (true) in
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.8, options: [], animations: {
                self.uil_announce.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }) { (true) in
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseOut], animations: {
                    self.uil_announce.transform = .identity
                }) { (true) in
                    self.animateMenuScoreTouched()
                }
            }
        }
    }
    func animateMenuScoreTouched() {
    
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
            self.uil_score_touched.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (true) in
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.8, options: [], animations: {
                self.uil_score_touched.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }) { (true) in
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseOut], animations: {
                    self.uil_score_touched.transform = .identity
                }) { (true) in
                    self.animateQuitButtonOulet()
                }
            }
        }
    }
    func animateQuitButtonOulet() {
    
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
            self.quitGameButtonOutlet.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (true) in
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.8, options: [], animations: {
                self.quitGameButtonOutlet.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }) { (true) in
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseOut], animations: {
                    self.quitGameButtonOutlet.transform = .identity
                }) { (true) in
                    self.animateNewGameButtonOulet()
                }
            }
        }
    }
    
    func displayGreenUp() {
        
        imageViewGame = UIImageView(frame: CGRect(x: possibleOrigins.randomElement()!.x, y: possibleOrigins.randomElement()!.y, width: uiview_game.frame.width / 5, height: uiview_game.frame.height / 3))
        
        imageViewGame.image = ARROWS[0]
        modelGame = imageGameToFind(arrowDirection: .up, colors: .green)
            
        uiview_game.addSubview(imageViewGame)
        animateTheView(withView: imageViewGame)
    }
    
    func displayGreenDown() {
        
        imageViewGame = UIImageView(frame: CGRect(x: possibleOrigins.randomElement()!.x, y: possibleOrigins.randomElement()!.y, width: uiview_game.frame.width / 5, height: uiview_game.frame.height / 3))
        
        imageViewGame.image = ARROWS[1]
        modelGame = imageGameToFind(arrowDirection: .down, colors: .green)
       
        uiview_game.addSubview(imageViewGame)
        animateTheView(withView: imageViewGame)
        
    }
    
    func displayRedUp() {
        
        imageViewGame = UIImageView(frame: CGRect(x: possibleOrigins.randomElement()!.x, y: possibleOrigins.randomElement()!.y, width: uiview_game.frame.width / 5, height: uiview_game.frame.height / 3))
        
        imageViewGame.image = ARROWS[2]
        modelGame = imageGameToFind(arrowDirection: .up, colors: .red)
            
        uiview_game.addSubview(imageViewGame)
        animateTheView(withView: imageViewGame)
    }
    
    func displayRedDown() {
        
        imageViewGame = UIImageView(frame: CGRect(x: possibleOrigins.randomElement()!.x, y: possibleOrigins.randomElement()!.y, width: uiview_game.frame.width / 5, height: uiview_game.frame.height / 3))
        
        imageViewGame.image = ARROWS[3]
        modelGame = imageGameToFind(arrowDirection: .down, colors: .red)
            
        uiview_game.addSubview(imageViewGame)
        animateTheView(withView: imageViewGame)
    }
    
//MARK: INIT & VAR & ARRAYS
   
    var modelGame = imageGameToFind()
    
    var modelRules = RulesForGame()
    
    var imageViewGame = UIImageView()
    
    var finalArrayFunctions: [(Void)] = [(Void)]()
    
    var timerGame = Timer()
       
    var timerGameLeft: Int = 60

    var isGameLive: Bool = true {
        didSet {
            switch isGameLive {
            case true:
                print("do something game is live")
            case false:
                print("do something game isnt live")
            }
            
        }
    }
    
    var scoreTouched: Int = 0 {
        didSet {
            print("uilscore touched didset")
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                self.uil_score_touched.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }) { (true) in
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.6, options: [], animations: {
                    self.uil_score_touched.transform = .identity
                })
            }
            
            uil_score_touched.text = "\(scoreTouched)"
        }
    }
    
    let ARROWS = [UIImage(named: "arrow_green_up"),         // 0 GREEWN DOWN
                      UIImage(named: "arrow_green_down"),   // 1 RED DOWN
                      UIImage(named: "arrow_red_up"),       // 2 GREEN UP
                      UIImage(named: "arrow_red_down")]     // 3 RED UP
    
    
    let possibleOrigins = [CGPoint(x: 50, y: 100),
                           CGPoint(x: 150, y: 100),
                           CGPoint(x: 300, y: 100),
                           CGPoint(x: 50, y: 400),
                           CGPoint(x: 150, y: 400),
                           CGPoint(x: 300, y: 400)]
    
    func randomOriginImageView() -> CGPoint {
        return possibleOrigins.randomElement()!
    }
    
// MARK: GAME LOGIC + SWIPES
  
    @objc func handlingSwipes(recognizer: UISwipeGestureRecognizer) { // FAILED: switch sur le model RULES en premnier
        
        let point0 = recognizer.location(ofTouch: 0, in: uiview_game)
        
        if imageViewGame.frame.contains(point0) && isGameLive == true {
            
            switch recognizer.direction {
                
                case .up:
                
                    switch modelGame.colors {
                    
                        case .red:
                            
                            switch modelGame.arrowDirection {
                                case .up:
                                    switch modelRules.isRedEnabled {
                                        case true:
                                            print("FAIL")
                                            uil_announce.textColor = .red
                                            uil_announce.text = "Failed!"
                                            uil_score_touched.textColor = .red
                    
                                        case false:
                                            print("WIN")
                                            uil_announce.textColor = .green
                                            uil_announce.text = "Touched!"
                                            scoreTouched += 1
                                            uil_score_touched.textColor = .green
                                    }
                                
                                case .down:
                                    switch modelRules.isRedEnabled {
                                        case true:
                                            print("WIN")
                                            uil_announce.textColor = .green
                                            uil_announce.text = "Touched!"
                                            scoreTouched += 1
                                            uil_score_touched.textColor = .green
                                        case false:
                                            uil_announce.textColor = .red
                                            uil_announce.text = "Failed!"
                                            uil_score_touched.textColor = .red
                                            print("FAIL")
                                    }
                                
                                case .none:
                                
                                    print("NOT UP OR DOWN")
                            }
        
                        
                        case .green:                                            //  CASE UP .green
                    
                            switch modelGame.arrowDirection {
                                
                                case .up:
                                    uil_announce.textColor = .green
                                    uil_announce.text = "Touched!"
                                    scoreTouched += 1
                                    uil_score_touched.textColor = .green
                                case .down:
                                    uil_announce.textColor = .red
                                    uil_announce.text = "Failed!"
                                    uil_score_touched.textColor = .red
                                case .none:
                                    print("NOT UP OR DOWN")
                    }
                    
                case .none:
                    print("NO RED OR GREEN")
                }
                
                
                
            case .down:
                
                switch modelGame.colors {
                    
                    case .red:                                              // CASE DOWN .red
                        
                        switch modelGame.arrowDirection {
                            case .up:
                                switch modelRules.isRedEnabled {
                                    case true:
                                        
                                        uil_announce.textColor = .green
                                        uil_announce.text = "Touched!"
                                        scoreTouched += 1
                                        uil_score_touched.textColor = .green
                
                                    case false:
                                        
                                        uil_announce.textColor = .red
                                        uil_announce.text = "Failed!"
                                        uil_score_touched.textColor = .red
                                        
                                }
                            
                            case .down:
                                switch modelRules.isRedEnabled {
                                    case true:
                                    
                                        uil_announce.textColor = .red
                                        uil_announce.text = "Failed!"
                                        uil_score_touched.textColor = .red
                        
                                    case false:
                                        uil_announce.textColor = .green
                                        uil_announce.text = "Touched!"
                                        scoreTouched += 1
                                        uil_score_touched.textColor = .green
                                    
                                }
                            
                            case .none:
                            
                                print("NOT UP OR DOWN")
                        }
                    
                    case .green:                                            // case DOWN .green
                        
                        switch modelGame.arrowDirection {
                        
                            case .up:
                                uil_announce.textColor = .red
                                uil_announce.text = "Failed!"
                                uil_score_touched.textColor = .red
                            case .down:
                                print("matched!")
                                uil_announce.textColor = .green
                                uil_announce.text = "Touched!"
                                scoreTouched += 1
                                uil_score_touched.textColor = .green
                            case .none:
                                print("neither up or down")
                        }
                    
                    case .none:
                        print("NO RED OR GREEN")
                }
            default:
                print("NO DIRECTION")
            }
        } else {
            print("touch not in view ! or touch disabled")
            print(point0)
            print(isGameLive)
        }
        
    }
    
// MARK: OULET & BUT MAIN VIEW
    
    @IBOutlet var uiview_player: UIView! {
        didSet {
            self.uiview_player.layer.cornerRadius = 20
        }
    }
    
    @IBOutlet var uiview_game: UIView! {
        didSet {
            self.uiview_game.layer.cornerRadius = 40
        }
    }
       
    @IBOutlet var uil_announce: UILabel!
       
    @IBOutlet var uil_score_touched: UILabel!
    
    @IBOutlet var newGameButtonOutlet: UIButton!
    
    @IBOutlet var quitGameButtonOutlet: UIButton!
    
    @IBAction func newGameButton(_ sender: UIButton) {    //en chantier
        print("newg gamtouch")
        if isGameLive {
            print("gameislive")
        } else {
          // should show menu
        }
        
    }
    
    @IBAction func quitGameButton(_ sender: UIButton) {  //moitier chantier
        print("quit gamtouch")
        self.dismiss(animated: false) {
            self.isGameLive = false
            print("game dismiss")
        }
    }
    
// MARK: OUTLET & BUT MENU VIEW
    
    @IBOutlet var uiv_menu_choice: UIView!
    
    @IBOutlet var UIm_manches: UILabel!
    
    @IBOutlet var UIsc_manches_Outlet: UISegmentedControl!
    
    @IBAction func UIsc_manches(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            modelRules.numberOfArrowDisplayed = 10
            UIm_manches.text = "Manches: 10"
        case 1:
            modelRules.numberOfArrowDisplayed = 20
            UIm_manches.text = "Manches: 20"
        case 2:
            modelRules.numberOfArrowDisplayed = 30
            UIm_manches.text = "Manches: 30"
        default:
            print("not a segment")
        }
        
    }
    
    @IBOutlet var UIl_rouge_inverse: UILabel!
    
    @IBOutlet var UIS_rouge_OUTLET: UISwitch!
    
    @IBAction func UISwitch_rouge_inverse(_ sender: UISwitch) {
        
        switch sender.isOn {
        case true:
            modelRules.isRedEnabled = true
        case false:
            modelRules.isRedEnabled = false
        }
    }
    
    @IBOutlet var UIl_vitesse: UILabel!
    
    @IBOutlet var UIs_vitesse_OUTLET: UISlider!
    
    @IBAction func UISlider_vitesse(_ sender: UISlider) {
    
        
        switch sender.value {
        case 1...1.7:
            modelRules.delayBetweenTwoCard = 3
            UIl_vitesse.text = "Vitesse: 1"
        case 1.8...2.2:
            modelRules.delayBetweenTwoCard = 2
            UIl_vitesse.text = "Vitesse: 2"
        case 2.3...3:
            modelRules.delayBetweenTwoCard = 1
            UIl_vitesse.text = "Vitesse: 3"
        default:
            print("not a vitesse between 1 and 3")
        }
        
    }
    
    @IBAction func goButtonView(_ sender: UIButton) {
        UIView.animate(withDuration: 1, animations: {
            self.uiv_menu_choice.alpha = 0
        }) { (true) in
            self.prepareAGame(rules: self.modelRules)
        }
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        
        UIm_manches.text = "Manches: 10"
        UIsc_manches_Outlet.selectedSegmentIndex = 0
        UIS_rouge_OUTLET.isOn = true
        UIs_vitesse_OUTLET.setValue(2, animated: true)
        
    }
    
//MARK: RANDOMLY APPLYING GAMELOGIC
    
    func prepareAGame(rules: RulesForGame) { // prepare the timer + launche the game after 1s
        
        timerGameLeft = Int(modelRules.numberOfArrowDisplayed) * Int(modelRules.delayBetweenTwoCard)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.timerGame = Timer.scheduledTimer(timeInterval: self.modelRules.delayBetweenTwoCard, target: self, selector: #selector(self.createImageInSequence), userInfo: nil, repeats: true)
        }
    }
    
    @objc func createImageInSequence() { // Choose an image and display it if timergameleft different a 0
        
        randomlyChooseAnImageAndDisplayIt()
        
        if timerGameLeft == 0 {
            timerGame.invalidate()
            print("gameover")
        } else {
            timerGameLeft -= Int(modelRules.delayBetweenTwoCard)
        }
        
    }
    
    func randomlyChooseAnImageAndDisplayIt() { // Choisi limage en fonction du model RULES, is red enabled?
        
        let randomInt = Int.random(in: 0...3)
        let randomIntTwo = Int.random(in: 0...1)
        
        switch modelRules.isRedEnabled {
            case true:
                
                switch randomInt {
                    case 0:
                        displayRedUp()
                    case 1:
                        displayRedDown()
                    case 2:
                        displayGreenUp()
                    case 3:
                        displayGreenDown()
                default:
                    print("Should be 0 1 2 or 3")
                }
            
            case false:

                switch randomIntTwo {
                    case 0:
                        displayGreenUp()
                    case 1:
                        displayGreenDown()
                default:
                    print("Should be 0 or 1")
                }
        }
        
    }
}

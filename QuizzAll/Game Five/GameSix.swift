//
//  GameSix.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 30/12/2019.
//  Copyright © 2019 Nicolas Richard. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import SpriteKit

enum GameState {
    case BurgondePlay
    case PlayerPlay
    case NoonePlay
}

class GameSix: UIViewController, UITextFieldDelegate {
    
    func applyGameState(withState state:GameState) {
        switch state {
        case .BurgondePlay:
            print("1")
        case .PlayerPlay:
            print("2")
        case .NoonePlay:
            print("3")
        }
    }
    
    @IBOutlet var uiv_spkview: SKView!
    
    let knightNames = ["Chevalier au Saucisson.", "Vicompte du Salami.", "Chef des Fromages.", "Duc de la Vinasserie.", "Roi des Cons."]
    
    var soundMenu = [
        URL(fileURLWithPath: Bundle.main.path(forResource: "burgonde_ahah", ofType: "mp3")!),
        URL(fileURLWithPath: Bundle.main.path(forResource: "burgonde_cest_la_guerre_", ofType: "mp3")!),
        URL(fileURLWithPath: Bundle.main.path(forResource: "burgonde_cest_la_guerre_", ofType: "mp3")!)
    ]

    @IBOutlet var uiv_menu: UIView!             // TAG: 0 bk + uitextintro + uitname + bgo
    @IBOutlet var uiv_confirmation: UIView!     // TAG: 1 bk + ulconfirm + ybut + nbut
    
    @IBOutlet var uiv_burgonde: UIView!         // TAG: 2 imgburgonde + uiltext
    @IBOutlet var uiv_userui: UIView!           // TAG: 3 4 buttons
    
    @IBOutlet var uiv_popup_turn: UIView!       // TAG: 4 bk + uilpopup + OKbut
    
    @IBOutlet var uit_name: UITextField!
    
    @IBOutlet var uib_go_outlet: UIButton!
    
    @IBOutlet var uil_textBot: UILabel!
    @IBOutlet var uil_text_intro: UILabel!
    @IBOutlet var uil_popup: UILabel!
    
    @IBOutlet var uil_confirmation_name: UILabel!
    @IBOutlet var uil_you_just_played: UILabel!
    
    lazy var burgonde_player = Burgonde()
    
    lazy var human_player = Player()
    
    var namePlayer: String = ""
    
    var isPlayerTurn: Bool = false {
        didSet {
            switch isPlayerTurn {
            case true:
                setupUIAccordingToPlayer()
            case false:
                setupUIAccordingToBot()
            }
        }
    }
    
    var audioMenu = AVAudioPlayer()
    var timerSoundMenu = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uit_name.delegate = self
        uiv_burgonde.removeFromSuperview()
        uiv_confirmation.removeFromSuperview()
        uiv_userui.removeFromSuperview()
        uiv_popup_turn.removeFromSuperview()
        uiv_menu.removeFromSuperview()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            self.animeView(withView: self.uiv_menu)
        }

        timerSoundMenu = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(makeRandomSound), userInfo: nil, repeats: true)
        timerSoundMenu.fire()
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: FUNCTION SOUND
    
    
    @objc func makeRandomSound() {
        print("sounded")
        do {
            audioMenu = try AVAudioPlayer(contentsOf: soundMenu.randomElement()!)
            audioMenu.play()
        } catch let error {
            print(error)
        }
    }
    
    
    // MARK: FUNCTION VIEW & POPUP
    
    
    func animeView(withView view1: UIView) {
        switch view1.tag {
        case 0:
            view1.center = CGPoint(x: self.view.frame.width / 2, y: -self.view.frame.height)
            UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
                view1.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height * 1.5)
            })
            view.addSubview(view1)
        case 1:
            view1.center = CGPoint(x: self.view.frame.width / 2, y: -self.view.frame.height)
            UIView.animate(withDuration: 1.5, delay: 1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
                view1.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height * 1.5)
            })
            view.addSubview(view1)
        case 2:
            view1.center = CGPoint(x: -self.view.frame.width, y: 82)
            UIView.animate(withDuration: 1.5, delay: 1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
                view1.transform = CGAffineTransform(translationX: self.view.frame.width * 1.5, y: 0)
            })
            //faire un uivview animate pour burgonde
            view.addSubview(view1)
        case 3:
            view1.center = CGPoint(x: -self.view.frame.width, y: 652)
            UIView.animate(withDuration: 1.5, delay: 2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
                view1.transform = CGAffineTransform(translationX: self.view.frame.width * 1.5, y: 0)
            })
            //faire un uiviewanimte pour uiuser
            view.addSubview(view1)
        case 4:
            
            view1.center = CGPoint(x: self.view.frame.width / 2, y: -self.view.frame.height)
            UIView.animate(withDuration: 1.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
                view1.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height * 1.5)
            })
            view.addSubview(view1)
            //faire un uiviewanimte pour pop up
        default:
            print("0 vision to add with the swtich")
        }
    }
    
    func invocTheGame() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            if let skviewBoard = GameScene6(fileNamed: "SceneGameBoard") {
                self.uiv_spkview.isHidden = false
                self.uiv_spkview.backgroundColor = .clear
                print("bla")
                self.uiv_spkview.presentScene(skviewBoard)
            }
        }
    }
    
    func dismissView(withView view1: UIView) {
        
        switch view1.tag {
        case 0:
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
                view1.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            })
        case 1:
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [], animations: {
                view1.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            })
            view.addSubview(view1)
        case 2:
            print("should dismiss burgonde")
        case 3:
            print("shoudl dismiss uiuser")
        case 4:
            print("shoudl dismiss popup")
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                view1.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            })
            
            
        case 5:
            print("shoudl dismiss game")
        default:
            print("0 view to dismiss with the swtich")
        }
    }
    
    func addPopUp(withName name: String) -> Void {
        if name == "au Roi Burgonde" {
            uil_popup.text = "C'est au Roi Burgonde de jouer!"
        }
        if name == namePlayer {
            uil_popup.text = "C'est à \(namePlayer) de jouer!"
        }
        animeView(withView: uiv_popup_turn)
    }
    
    
    // MARK: IBACTION BUTTON MENU
    
    
    @IBAction func uib_go(_ sender: Any) {
        uit_name.resignFirstResponder()
        
        let lastName = knightNames.randomElement()
           
        dismissView(withView: uiv_menu)
        animeView(withView: uiv_confirmation)
        uil_confirmation_name.text =
        "Cuillère...\n\n \(namePlayer),\n \(lastName!) \n\n C'est parti ?\nSalsifis ?\n Guerre ?"
    }
   
    @IBAction func uib_okdac(_ sender: UIButton) {
        dismissView(withView: uiv_popup_turn)
        if uil_popup.text == "C'est au Roi Burgonde de jouer!" {               // CROSS
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.isPlayerTurn = false
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.isPlayerTurn = true
            }
        }
    }
    
    @IBAction func uib_oupas(_ sender: UIButton) {
        dismissView(withView: uiv_confirmation)
        animeView(withView: uiv_menu)
    }
    
    @IBAction func uib_oui(_ sender: UIButton) {
        
        timerSoundMenu.invalidate()
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.dismissView(withView: self.uiv_confirmation)
            self.animeView(withView: self.uiv_burgonde)
            self.animeView(withView: self.uiv_userui)
            self.invocTheGame()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.isPlayerTurn = false
        }
    }
    
    // MARK: UPDATE UIGAME LOGIC
 
    func setupUIAccordingToPlayer() {
        uiv_userui.isUserInteractionEnabled = true
    }

    func setupUIAccordingToBot() {
        uiv_userui.isUserInteractionEnabled = false
        burgonde_player.playRandomMoove()
        
        uil_textBot.text = burgonde_player.currentBurgondeCitation
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            self.addPopUp(withName: self.namePlayer)
        }
    }
    
    //MARK: HANDLING NAME PLAYER
    
    func ifNameOkViewChange(withName name: String) -> Bool {
        if name.count >= 2, name.count < 16 {
            uib_go_outlet.isEnabled = true
            uib_go_outlet.alpha = 1
            return true
        } else {
            uib_go_outlet.isEnabled = false
            uib_go_outlet.alpha = 0.5
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        uit_name.resignFirstResponder()
        return true
    }
    
    @IBAction func nameDidChanged(_ sender: UITextField) {
        if let name = uit_name.text {
            if ifNameOkViewChange(withName: name) == true {
                namePlayer = name
                print("name ok, view can change")
            } else {
                print("name not ok")
            }
        }
    }
    
    
    // MARK: FONCTIONS UIGAMER
    
    
    func playerPlayed() {
        uiv_userui.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.uil_you_just_played.text = "You..."
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
            self.uil_you_just_played.text = "You... Just..."
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)){
            self.uil_you_just_played.text = "You... Just... Played..."
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.addPopUp(withName: "au Roi Burgonde")
        }
    }
    
    @IBAction func addAnEgg(_ sender: UIButton) {
        playerPlayed()
        print("1")
    }
    
    @IBAction func mooveAnEgg(_ sender: UIButton) {
        playerPlayed()
        print("2")
    }
    
    @IBAction func askPerceval(_ sender: UIButton) {
        human_player.askPerceval()
        playerPlayed()
        print("3")
    }
    
    @IBAction func AskBohort(_ sender: UIButton) {
        human_player.askBohort()
        playerPlayed()
        print("4")
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  GameViewController.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 03/04/2019.
//  Copyright © 2019 Nicolas Richard. All rights reserved.
//

import UIKit
import Foundation

class GameViewController: UIViewController {
    
    
    //listes outlet
    
    
    
    @IBOutlet weak var label_321: UILabel!
    
    var timerBalle = Timer()
    
    
    func ballPerdu() {
        
        nbBoules = nbBoules - 1
        
        timerBalle.invalidate()
        balle_game.alpha = 0
        balle_game.center = CGPoint(x: 15, y: 15)
        
        UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: [], animations: {
            self.palet_left.isUserInteractionEnabled = false
            self.palet_right.isUserInteractionEnabled = false
            self.palet_left.center = CGPoint(x: 20, y: 358)
            self.palet_right.center = CGPoint(x: 394, y: 358)
        }, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.palet_left.isUserInteractionEnabled = true
            self.palet_right.isUserInteractionEnabled = true
            self.newBalle()
        }

        
    }
    
    var scoreRicochet: Int = 0
    var nbBoules: Int = 3
    
    func calculBoules() {
        if nbBoules == 3 {
            bouboules_restantes.text = "Boules : 3"
            animGame1()
        }
        else if nbBoules == 2 {
            bouboules_restantes.text = "Boules : 2"
            animGame2()
        }
        else if nbBoules == 1 {
            bouboules_restantes.text = "Boules : 1"
            animGame3()
        }
    }
    
    func calculRicochet() {
        score_ricochet.text = String(scoreRicochet)
    }
    
    func gameReallyOver() {
        score_ricochet.text = "?"
        bouboules_restantes.text = "Perdu !"
        
    }
    func newBalle() {
        calculBoules()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            self.balle_game.alpha = 1
            self.locationBalle = CGPoint(x: 15, y: 15)
            self.timerBalle.fire()
            }
        
 
    }
    
    func launchGame() {
        
        calculBoules()
        timerBalle = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (Timer) in
            self.bougerBalle()
        }
        locationBalle = CGPoint(x: 5, y: 5)
        
    }
    
    
    func animObjects() {
        
        UIView.animateKeyframes(withDuration: 4, delay: 0, options: [], animations: {
                self.balle_game.alpha = 1
                self.bouboules_restantes.alpha = 1
                self.score_ricochet.alpha = 1
            }, completion: nil)
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.score_ricochet.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            self.bouboules_restantes.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            self.balle_game.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            
        }, completion: nil)
      
    }
    
    
    
    func animate321() {
        
            UIView.animate(withDuration: 1, delay: 3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                self.label_321.alpha = 1
                self.label_321.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }) { (true) in
                UIView.animateKeyframes(withDuration: 0.25, delay: 1, options: [], animations: {
                    self.label_321.alpha = 0
                }, completion: { (true) in
                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                        self.label_321.text = "2"
                        self.label_321.alpha = 1
                        self.label_321.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                    }, completion: { (true) in
                        UIView.animateKeyframes(withDuration: 0.25, delay: 0, options: [], animations: {
                            self.label_321.alpha = 0
                        }, completion: { (true) in
                            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                                self.label_321.text = "1"
                                self.label_321.alpha = 1
                                self.label_321.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                            }, completion: { (true) in
                                UIView.animateKeyframes(withDuration: 0.15, delay: 0, options: [], animations: {
                                    self.label_321.alpha = 0
                                }, completion: { (true) in
                                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                                        self.label_321.text = "0"
                                        self.label_321.alpha = 1
                                    }, completion: { (true) in
                                        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [], animations: {
                                            self.label_321.alpha = 0
                                        }, completion: { (true) in
                                            self.launchGame()
                                        })
                                    })
                                })
                            })
                        })
                    })
                })
            }
    }
    
    // jeu
    
    @IBOutlet weak var view_game: UIView!
    
    var locationBalle = CGPoint()
   
    @IBOutlet weak var balle_game: UIImageView!
    
    @IBOutlet var palet_right: UIImageView!
    @IBOutlet var palet_left: UIImageView!
    
    
    @IBOutlet weak var view_palet_left: UIView!
    @IBOutlet weak var view_palet_right: UIView!
    
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch1 = event?.touches(for: view_palet_left)?.first {
            let locationpalet_left: CGPoint = touch1.location(in: view_palet_left)
            palet_left.center = CGPoint(x: 20, y: locationpalet_left.y)
        }
        
        if let touch2 = event?.touches(for: view_palet_right)?.first {
            let locationpalet_right: CGPoint = touch2.location(in: view_palet_right)
            palet_right.center = CGPoint(x: 394, y: locationpalet_right.y)
        }
        
        
    }
    
    
    @objc func bougerBalle() {
        calculRicochet()
        
// mouvement balle
        balle_game.center = CGPoint(x: balle_game.center.x + locationBalle.x , y: balle_game.center.y + locationBalle.y)
// haut et bas de lecran
        if (balle_game.center.y < 0 || balle_game.center.y > view_game.bounds.size.height) {
            locationBalle.y = -locationBalle.y
            }
// cote droite et gaucghe
        if (balle_game.center.x < 0 || balle_game.center.x > view_game.bounds.size.width) {
            ballPerdu()
            }
//gameover
// but cpu too
        
// ricochet avec palet
        
        if balle_game.frame.intersects(palet_right.frame) {
            locationBalle.x = -locationBalle.x
            scoreRicochet += 1
        }
        if balle_game.frame.intersects(palet_left.frame) {
            locationBalle.x = -locationBalle.x
            scoreRicochet += 1
        }
        
// ricochet avec tetris
        
        
    }
    
    func gameOver() {
        // a completer
        
    }
    
    @IBOutlet var score_ricochet: UILabel!
    @IBOutlet var bouboules_restantes: UILabel!
    
    
    
    //
    // PARTIE ANIMATION TETRIS
    //
    
    @IBOutlet var ui_view_bleu: UIView!
    @IBOutlet var ui_view_jaune: UIView!
    
    
    
    func stopAnimLvl() {

    }
   
    var timerAnim1 = Timer()
    var timerAnim2 = Timer()
    var timerAnim3 = Timer()
    
    func anim1() {
        /*
        self.ui_tetris_bleudebout.center = CGPoint(x: 209, y: 140)
        self.ui_tetris_svert.center = CGPoint(x: 209, y: 460)
     
        self.ui_tetris_bleudebout.isHidden = true
        self.ui_tetris_svert.isHidden = true
       
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.ui_tetris_bleudebout.isHidden = false
            self.ui_tetris_svert.isHidden = false
        }
        */
        self.ui_view_jaune.isHidden = false

        UIView.animateKeyframes(withDuration: 2.5, delay: 0, options: [], animations: {
            self.ui_view_jaune.center = CGPoint(x: 206, y: 540)
        }) { (true) in
            
            UIView.animateKeyframes(withDuration: 2.5, delay: 0, options: [], animations: {
                self.ui_view_jaune.center = CGPoint(x: 206, y: 140)
            }, completion: nil)
    
        }
      
    }
   
    func animGame1() {
        
        timerAnim1 = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (Timer) in
            self.anim1()
        }
        timerAnim1.fire()
        
        
    }
    
    
    
    
    
    func animGame2() {
        
    }
    
    func animGame3() {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

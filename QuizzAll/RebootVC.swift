//
//  RebootVC.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 10/02/2020.
//  Copyright © 2020 Nicolas Richard. All rights reserved.
//

import UIKit

class RebootVC: UIViewController {
    
    override func viewDidLoad() {
        print("bla")
    }
	
    @objc func handlingSwipes(recognizer: UISwipeGestureRecognizer) {
        
        print(recognizer.location(ofTouch: 0, in: self.view))
   
        
        switch recognizer.direction {
        case .up:
            displayTextAccordingToGesture(withGesture: .swipeUp)
        case .down:
            displayTextAccordingToGesture(withGesture: .swipeDown)
        case .right:
            displayTextAccordingToGesture(withGesture: .swipeRight)
        case .left:
            displayTextAccordingToGesture(withGesture: .swipeLeft)
        default:
            print("errorm message displayed")
        }
    }
    
    @objc func handlingRotation(recognizer: UIRotationGestureRecognizer) {
        print(recognizer.velocity)
        print(recognizer.rotation)
        switch recognizer.velocity {
        case 0...2:
//            displayTextAccordingToGesture(withGesture: .velocity)
            lab_messageDisplayed.text = "Very Slow"
        case 3...6:
//            displayTextAccordingToGesture(withGesture: .velocity)
            lab_messageDisplayed.text = "Slow"
        case 7...15:
//            displayTextAccordingToGesture(withGesture: .velocity)
            lab_messageDisplayed.text = "Normal"
        case 16...:
//            displayTextAccordingToGesture(withGesture: .velocity)
            lab_messageDisplayed.text = "Fast"
        default:
            print("default")
        }
    }
    
    @objc func handlingTap(recognizer: UITapGestureRecognizer) {
        
        switch recognizer.numberOfTapsRequired {
        case 1:
            displayTextAccordingToGesture(withGesture: .numberOfTapsRequired)
        case 2:
            displayTextAccordingToGesture(withGesture: .numberOfTapsRequired)
        case 3:
            displayTextAccordingToGesture(withGesture: .numberOfTapsRequired)
        default:
            print("error")
        }
    }
    
    @IBOutlet var uiv_main: UIView! {
        didSet {
            let swipesRecognizerUp = UISwipeGestureRecognizer(target: self, action: #selector(RebootVC.handlingSwipes(recognizer:)))
            swipesRecognizerUp.direction = .up
            let swipesRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(RebootVC.handlingSwipes(recognizer:)))
            swipesRecognizerDown.direction = .down
            let swipesRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(RebootVC.handlingSwipes(recognizer:)))
            swipesRecognizerRight.direction = .right
            let swipesRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(RebootVC.handlingSwipes(recognizer:)))
            swipesRecognizerLeft.direction = .left
            
            let rotationRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(RebootVC.handlingRotation(recognizer:)))
            
            let tapsRecognizer = UITapGestureRecognizer(target: self, action: #selector(RebootVC.handlingTap(recognizer:)))
            
            self.uiv_main.addGestureRecognizer(rotationRecognizer)
            self.uiv_main.addGestureRecognizer(swipesRecognizerUp)
            self.uiv_main.addGestureRecognizer(swipesRecognizerDown)
            self.uiv_main.addGestureRecognizer(swipesRecognizerRight)
            self.uiv_main.addGestureRecognizer(swipesRecognizerLeft)
            self.uiv_main.addGestureRecognizer(tapsRecognizer)
            
        }
    }
    
    func displayTextAccordingToGesture(withGesture gesture: gestureTypes) -> Void {
        
        switch gesture {
        case .swipeUp:
            lab_messageDisplayed.text = "Up !"
        case .swipeDown:
            lab_messageDisplayed.text = "Down !"
        case .swipeRight:
            lab_messageDisplayed.text = "Right !"
        case .swipeLeft:
            lab_messageDisplayed.text = "Left !"
        case .velocity:
            lab_messageDisplayed.text = "Rotate !"
        case .numberOfTapsRequired:
            lab_messageDisplayed.text = "Taps"
        }
    }
  
    enum gestureTypes {
        case swipeUp
        case swipeDown
        case swipeRight
        case swipeLeft
        case velocity
        case numberOfTapsRequired
    }
    enum velocityRotate {
        case verySlow
        case slow
        case normal
        case fast
    }
    
    @IBOutlet var uii_background: UIImageView!
    @IBOutlet var lab_messageDisplayed: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

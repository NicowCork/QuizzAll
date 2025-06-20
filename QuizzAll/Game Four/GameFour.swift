//
//  GameFour.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 30/10/2019.
//  Copyright © 2019 Nicolas Richard. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class GameFour: UIViewController, UITextFieldDelegate {

    @IBOutlet var sk_view4: SKView!
    @IBOutlet var uiv_menu: UIView!
    @IBOutlet var uiv_background: UIImageView!
    
    @IBOutlet var uit_YourName: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        uit_YourName.resignFirstResponder()
      
        
        if let skview4 = GameScene4(fileNamed: "GameScene4") {
            sk_view4.isHidden = false
            sk_view4.presentScene(skview4)
        }
        uiv_menu.removeFromSuperview()
       
        return true
    }
    
    
    
    override func viewDidLoad() {
        self.uit_YourName.delegate = self
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}

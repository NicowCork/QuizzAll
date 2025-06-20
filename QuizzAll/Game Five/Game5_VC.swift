//
//  Game5_VC.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 16/12/2019.
//  Copyright © 2019 Nicolas Richard. All rights reserved.
//

import UIKit
import GameplayKit

struct imageGames {
    let white_pion = UIImage(named: "white_pion")
    let white_tour = UIImage(named: "white_tour")
    let white_cavalier = UIImage(named: "white_cavalier")
    let white_fou = UIImage(named: "white_fou")
    let white_reine = UIImage(named: "white_reine")
    let white_roi = UIImage(named: "white_roi")
    
    let black_pion = UIImage(named: "black_pion")
    let black_tour = UIImage(named: "black_tour")
    let black_cavalier = UIImage(named: "black_cavalier")
    let black_fou = UIImage(named: "black_fou")
    let black_reine = UIImage(named: "black_reine")
    let black_roi = UIImage(named: "black_roi")
}

class Game5_VC: UIViewController {
    var position = simd_int2(x: 10, y: 10)
   // lazy var game = GameChessNode(fromGridStartingAt: position, width: Int32(100), height: Int32(100), diagonalsAllowed: true)
    
    func setupDefaultPosition() {
        
        caseTouched[0].setBackgroundImage(imageGames.init().black_tour, for: UIControl.State.normal)
        caseTouched[1].setBackgroundImage(imageGames.init().black_cavalier, for: UIControl.State.normal)
        caseTouched[2].setBackgroundImage(imageGames.init().black_fou, for: UIControl.State.normal)
        caseTouched[3].setBackgroundImage(imageGames.init().black_roi, for: UIControl.State.normal)
        caseTouched[4].setBackgroundImage(imageGames.init().black_reine, for: UIControl.State.normal)
        caseTouched[5].setBackgroundImage(imageGames.init().black_fou, for: UIControl.State.normal)
        caseTouched[6].setBackgroundImage(imageGames.init().black_cavalier, for: UIControl.State.normal)
        caseTouched[7].setBackgroundImage(imageGames.init().black_tour, for: UIControl.State.normal)
        
        caseTouched[8].setBackgroundImage(imageGames.init().black_pion, for: UIControl.State.normal)
        caseTouched[9].setBackgroundImage(imageGames.init().black_pion, for: UIControl.State.normal)
        caseTouched[10].setBackgroundImage(imageGames.init().black_pion, for: UIControl.State.normal)
        caseTouched[11].setBackgroundImage(imageGames.init().black_pion, for: UIControl.State.normal)
        caseTouched[12].setBackgroundImage(imageGames.init().black_pion, for: UIControl.State.normal)
        caseTouched[13].setBackgroundImage(imageGames.init().black_pion, for: UIControl.State.normal)
        caseTouched[14].setBackgroundImage(imageGames.init().black_pion, for: UIControl.State.normal)
        caseTouched[15].setBackgroundImage(imageGames.init().black_pion, for: UIControl.State.normal)
        
        caseTouched[48].setBackgroundImage(imageGames.init().white_pion, for: UIControl.State.normal)
        caseTouched[49].setBackgroundImage(imageGames.init().white_pion, for: UIControl.State.normal)
        caseTouched[50].setBackgroundImage(imageGames.init().white_pion, for: UIControl.State.normal)
        caseTouched[51].setBackgroundImage(imageGames.init().white_pion, for: UIControl.State.normal)
        caseTouched[52].setBackgroundImage(imageGames.init().white_pion, for: UIControl.State.normal)
        caseTouched[53].setBackgroundImage(imageGames.init().white_pion, for: UIControl.State.normal)
        caseTouched[54].setBackgroundImage(imageGames.init().white_pion, for: UIControl.State.normal)
        caseTouched[55].setBackgroundImage(imageGames.init().white_pion, for: UIControl.State.normal)
        
        caseTouched[56].setBackgroundImage(imageGames.init().white_tour, for: UIControl.State.normal)
        caseTouched[57].setBackgroundImage(imageGames.init().white_cavalier, for: UIControl.State.normal)
        caseTouched[58].setBackgroundImage(imageGames.init().white_fou, for: UIControl.State.normal)
        caseTouched[59].setBackgroundImage(imageGames.init().white_reine, for: UIControl.State.normal)
        caseTouched[60].setBackgroundImage(imageGames.init().white_roi, for: UIControl.State.normal)
        caseTouched[61].setBackgroundImage(imageGames.init().white_fou, for: UIControl.State.normal)
        caseTouched[62].setBackgroundImage(imageGames.init().white_cavalier, for: UIControl.State.normal)
        caseTouched[63].setBackgroundImage(imageGames.init().white_tour, for: UIControl.State.normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultPosition()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var caseTouched: [UIButton]!
    
  
}

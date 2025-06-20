//
//  Player_war.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 10/01/2020.
//  Copyright © 2020 Nicolas Richard. All rights reserved.
//

import Foundation
import AVFoundation

class Player {
    
    private var audioPerceval = AVAudioPlayer()
    private var audioBohort = AVAudioPlayer()
    
    private let arraySoundBohort = [
        URL(fileURLWithPath: Bundle.main.path(forResource: "cest_pas_jo_le_rigolo", ofType: "mp3")!),
        URL(fileURLWithPath: Bundle.main.path(forResource: "cest_pas_jo_le_rigolo", ofType: "mp3")!)
    ]
    private let arraySoundPerceval = [
        URL(fileURLWithPath: Bundle.main.path(forResource: "voila_cest_pro", ofType: "mp3")!),
        URL(fileURLWithPath: Bundle.main.path(forResource: "voila_cest_pro", ofType: "mp3")!)
    ]
    
    func askPerceval() {
        print("ask perceval")
        do {
            try audioPerceval = AVAudioPlayer(contentsOf: arraySoundPerceval.randomElement()!)
            audioPerceval.play()
            print("ask perceval1")
        } catch let error{
            print(error)
        }
    }
    
    func askBohort() {
        print("ask perceval")
        do {
            try audioBohort = AVAudioPlayer(contentsOf: arraySoundBohort.randomElement()!)
            audioBohort.play()
        } catch let error {
            print(error)
        }
    }
}

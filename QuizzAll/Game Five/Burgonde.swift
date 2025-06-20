//
//  ViewManager.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 03/01/2020.
//  Copyright © 2020 Nicolas Richard. All rights reserved.
//

import Foundation
import AVFoundation

struct Burgonde {
    struct DataBurgonde {
        
        private enum textBurgonde {
            static let text1 = "Arthour, pas changer assiettes pour fromage !"
            static let text2 = "Arthour ... Arthour !"
            static let text3 = "Cuillère... Cuillère... Cuillère... CUILLERE ! Ave ! Cesar !"
            static let text4 = "Cuillère !"
            static let text5 = "La fleur en bouquet fane, et jamais ne renaît !"
            static let text6 = "J’apprécie les fruits au sirop !"
            static let text7 = "METEOOOOOOO !"
            static let text8 = "Non posso volo, no tépo mayo. Un posso volo, tandolon toulo. Tamasso, tanlamalasso. Tamasso, les oiseaux petits..."
            static let text9 = "Oh ! Ca fait rien !"
            static let text10 = "On est en fort ! En pomme."
            static let text11 = "Qu'est-ce à dire que ceci ?"
            static let text12 = "Tres bien !"
            static let text13 = "Cuillère..."
        }
        
        private enum soundBurgonde {
            static let sound1 = URL(fileURLWithPath: Bundle.main.path(forResource: "assiette_fromage", ofType: "mp3")!)                // 3 sec
            static let sound2 = URL(fileURLWithPath: Bundle.main.path(forResource: "arthour", ofType: "mp3")!)                         // 2 sec
            static let sound3 = URL(fileURLWithPath: Bundle.main.path(forResource: "ave_cesar", ofType: "mp3")!)                      // 11 sec
            static let sound4 = URL(fileURLWithPath: Bundle.main.path(forResource: "cuillere_2", ofType: "mp3")!)                       // 1sec
            static let sound5 = URL(fileURLWithPath: Bundle.main.path(forResource: "fleur_en_bouquet", ofType: "mp3")!)
            static let sound6 = URL(fileURLWithPath: Bundle.main.path(forResource: "j_apprecie_les_fruits_au_sirop", ofType: "mp3")!)
            static let sound7 = URL(fileURLWithPath: Bundle.main.path(forResource: "meteo", ofType: "mp3")!)
            static let sound8 = URL(fileURLWithPath: Bundle.main.path(forResource: "nuo_pusso_volo", ofType: "mp3")!)
            static let sound9 = URL(fileURLWithPath: Bundle.main.path(forResource: "oh_ca_fait_rien", ofType: "mp3")!)
            static let sound10 = URL(fileURLWithPath: Bundle.main.path(forResource: "on_est_forts_en_pommes", ofType: "mp3")!)
            static let sound11 = URL(fileURLWithPath: Bundle.main.path(forResource: "qu-est_ce_dire_que_ceci", ofType: "mp3")!)
            static let sound12 = URL(fileURLWithPath: Bundle.main.path(forResource: "tres_bien", ofType: "mp3")!)
            static let sound13 = URL(fileURLWithPath: Bundle.main.path(forResource: "cuillere", ofType: "mp3")!)
        }
        
        static var DatasCitationSound: Dictionary<String,URL> = {
            
            let datas = [
                textBurgonde.text1 : soundBurgonde.sound1,
                textBurgonde.text2 : soundBurgonde.sound2,
                textBurgonde.text3 : soundBurgonde.sound3,
                textBurgonde.text4 : soundBurgonde.sound4,
                textBurgonde.text5 : soundBurgonde.sound5,
                textBurgonde.text6 : soundBurgonde.sound6,
                textBurgonde.text7 : soundBurgonde.sound7,
                textBurgonde.text8 : soundBurgonde.sound8,
                textBurgonde.text9 : soundBurgonde.sound9,
                textBurgonde.text10 : soundBurgonde.sound10,
                textBurgonde.text11 : soundBurgonde.sound11,
                textBurgonde.text12 : soundBurgonde.sound12,
                textBurgonde.text13 : soundBurgonde.sound13
            ]
                
            var urls = Dictionary<String,URL>()
            
            for (key, value) in datas {
                urls[key] = value
            }
            return urls
        }()
    }
    
    mutating func playRandomMoove() {
        
        if let moove = DataBurgonde.DatasCitationSound.randomElement() {
            currentBurgondeCitation = moove.key
            currentBurgongeSound = moove.value
        } else {
            print("no moove to play")
        }
    }
    
    var currentBurgondeCitation: String? {
        didSet {
            lastBurgondeCitation = oldValue
        }
    }
    
    var currentBurgongeSound: URL? {
        didSet {
            lastBurgondeSound = oldValue
            playSound(sound: currentBurgongeSound!)
        }
    }
    
    var lastBurgondeSound: URL? {
        didSet {
            if let lastSound = lastBurgondeSound {
                print(lastSound)
            } else {
                print("First Sound!")
            }
            
        }
    }
    var lastBurgondeCitation: String? {
        didSet {
            if let lastCitation = lastBurgondeCitation {
                print(lastCitation)
            } else {
                print("First citation!")
            }
            
        }
    }
    
    private var audioBurgonde = AVAudioPlayer()
    
    private mutating func playSound(sound: URL) -> Void {
        do {
            audioBurgonde = try AVAudioPlayer(contentsOf: sound)
            audioBurgonde.play()
        } catch {
            print("cant play burgonde")
        }
    }
   
}
    
//    mutating func playTurn() -> String {
//
//        var textIn = ""
//        var songLast = 0
//
//
//        switch turn {
//        case 1:
//            playSound(sound: (DataBurgonde.DatasBurgonde.randomElement()?.value)!)
//            songLast = 4
//        case 2:
//            playSound(sound: soundBurgonde.sound2)
//            textIn = textBurgonde.text2
//            songLast = 4
//        case 3:
//            playSound(sound: soundBurgonde.sound3)
//            textIn = textBurgonde.text3
//            songLast = 4
//        case 4:
//            playSound(sound: soundBurgonde.sound4)
//            textIn = textBurgonde.text4
//            songLast = 4
//        case 5:
//            playSound(sound: soundBurgonde.sound5)
//            textIn = textBurgonde.text5
//            songLast = 4
//        case 6:
//            playSound(sound: soundBurgonde.sound6)
//            textIn = textBurgonde.text6
//            songLast = 4
//        case 7:
//            playSound(sound: soundBurgonde.sound7)
//            textIn = textBurgonde.text7
//            songLast = 4
//        case 8:
//            playSound(sound: soundBurgonde.sound8)
//            textIn = textBurgonde.text8
//            songLast = 4
//        case 9:
//            playSound(sound: soundBurgonde.sound9)
//            textIn = textBurgonde.text9
//        case 10:
//            playSound(sound: soundBurgonde.sound10)
//            textIn = textBurgonde.text10
//        case 11:
//            playSound(sound: soundBurgonde.sound11)
//            textIn = textBurgonde.text11
//        case 12:
//            playSound(sound: soundBurgonde.sound12)
//            textIn = textBurgonde.text12
//        case 13:
//            playSound(sound: soundBurgonde.sound13)
//            textIn = textBurgonde.text13
//        case 14:
//            print("GAME OVER")
//
//        default:
//            print("no turn to play in burgonde")
//        }
//
//        turn += 1
//        return textIn
//    }
    

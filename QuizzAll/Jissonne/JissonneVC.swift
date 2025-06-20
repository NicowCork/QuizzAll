//
//  JissonneVC.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 14/04/2020.
//  Copyright © 2020 Nicolas Richard. All rights reserved.
//

import UIKit

class JissonneVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    var JSonRequestObject = JSonStructReceive(id: 0,
                                               name: "",
                                               status: "",
                                               species: "",
                                               type: "",
                                               gender: "",
                                               origin: "",
                                               location: "",
                                               image: "",
                                               episode: [""],
                                               url: "",
                                               created: "")
     
     
     
     var urlRequestCharacter = URL(string: "")
     
    
    // MARK: Outlet
    
    @IBOutlet var ui_name: UILabel!
    @IBOutlet var ui_status: UILabel!
    @IBOutlet var ui_species: UILabel!
    @IBOutlet var ui_gender: UILabel!
    @IBOutlet var ui_origin: UILabel!
    @IBOutlet var ui_location: UILabel!
    @IBOutlet var ui_picture: UIImageView!
    
    var dataImage = Data()
    
    func updateUI() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
            self.ui_name.text = self.JSonRequestObject.name
            self.ui_status.text = self.JSonRequestObject.status
            self.ui_species.text = self.JSonRequestObject.species
            self.ui_gender.text = self.JSonRequestObject.gender
            self.ui_origin.text = self.JSonRequestObject.origin
            self.ui_location.text = self.JSonRequestObject.location

            self.ui_picture.image = UIImage(data: self.dataImage)
            
        }
    }

    
    @IBAction func buttonPressed(_ sender: UIButton) {

        getRandomCharacterFrom0To20(withID: Int.random(in: 0...19), withPages: Int.random(in: 1...20), completion: updateUI())
        
    }
    
    
    func getRandomCharacterFrom0To20(withID id: Int, withPages page: Int, completion: Void) {
        
        
        if let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(page)") {
            
            print(url)
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                
                    do {
                    
                        let res = try JSONDecoder().decode(JSonCharacter.self, from: data)
                       
                        self.JSonRequestObject.id = res.results[id].id
                        self.JSonRequestObject.name = res.results[id].name
                        self.JSonRequestObject.status = res.results[id].status
                        self.JSonRequestObject.species = res.results[id].species
                        self.JSonRequestObject.type = res.results[id].type
                        self.JSonRequestObject.gender = res.results[id].gender
                        self.JSonRequestObject.origin = res.results[id].origin.name
                        self.JSonRequestObject.location = res.results[id].location.name
                        self.JSonRequestObject.image = res.results[id].image
                        
                        let url = URL(string: self.JSonRequestObject.image)
                        
                        if let data = try? Data(contentsOf: url!) {
                            self.dataImage = data
                        }
                        
                        print(res.results[id])
                        print(self.JSonRequestObject)
                        
                        } catch let error {
                            print(error)
                        }
                }
            
            }.resume()
        }

    }
  
    
}

//
//  RickAndMortyVC.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 16/04/2020.
//  Copyright © 2020 Nicolas Richard. All rights reserved.
//

import UIKit

class RickAndMortyVC: UIViewController, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if RangedCharactersTransformedFromJson.count > 5 {
            return 5
        } else {
            return RangedCharactersTransformedFromJson.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ResidentCell", for: indexPath)
        
        DispatchQueue.main.async {
            for _ in self.RangedCharactersTransformedFromJson {
                if let cellName = cell.textLabel {
                    cellName.textColor = #colorLiteral(red: 0.7882352941, green: 0.3490196078, blue: 0.02352941176, alpha: 1)
                    cellName.text = "\(self.RangedCharactersTransformedFromJson[indexPath.row].name)"
                }
                if let cellImage = cell.imageView {
                    if let data = try? Data(contentsOf: URL(string: self.RangedCharactersTransformedFromJson[indexPath.row].image)!) {
                        cellImage.image = UIImage(data: data)
                    }
                }
                
            }
            
        }
        
        return cell
    }
    
    
    // MARK: Outlets

    @IBOutlet var ui_tableview_residents: UITableView!
    
    @IBOutlet var ui_RickAndMortyImage: UIImageView!
    
    @IBOutlet var ui_button_characters: UIButton!
    @IBOutlet var ui_button_episodes: UIButton!
    @IBOutlet var ui_button_locations: UIButton!
    @IBOutlet var ui_button_origin_right: UIButton!
    @IBOutlet var ui_button_location_right: UIButton!
    
    
    @IBOutlet var ui_view_character: UIView!
    @IBOutlet var ui_view_episode: UIView!
    @IBOutlet var ui_view_location: UIView!
    
    @IBOutlet var ui_character_image: UIImageView!
    @IBOutlet var ui_character_name: UILabel!
    @IBOutlet var ui_character_status: UILabel!
    @IBOutlet var ui_character_species: UILabel!
    @IBOutlet var ui_character_origin: UILabel!
    @IBOutlet var ui_character_lastlocation: UILabel!
  
    @IBOutlet var ui_episodes_name: UILabel!
    @IBOutlet var ui_episodes_airdate: UILabel!
    @IBOutlet var ui_episodes_episode: UILabel!
    
    @IBOutlet var ui_location_name: UILabel!
    @IBOutlet var ui_location_type: UILabel!
    @IBOutlet var ui_location_dimension: UILabel!
    
    
    // MARK: JSonObject & Var
    
    var SelectedEpisodeTransformedFromJson = JSonSelectedEpisodeReceived(id: 0, name: "", air_date: "", episode: "", url: "", created: "", character: [""])
    
    var SelectedCharacterTransformedFromJson = JSonSelectedCharacterReceived(id: 0, name: "", status: "", species: "", type: "", gender: "", origin: "", originURL: "", location: "", locationURL: "", image: "", imageData: Data(), episodes: [""], url: "", created: "")
    
    var SelectedLocationTransformedFromJson = JSonSelectedLocationReceived(id: 0, name: "", type: "", dimension: "", residents: [""], url: "", created: "")
    
    var RangedCharactersTransformedFromJson = [JSonRangedCharacters]()
    
    enum positionActualViewDisplayed { case none, episode, character, location }
    
    var currentViewDisplayed: positionActualViewDisplayed = .none {
        didSet {
            handlingButtonFromViewState()
        }
    }
    
    private let x0: CGFloat = -774   // left
    private let x1: CGFloat = -360
    private let x2: CGFloat = 54     // center
    private let x3: CGFloat = 468
    private let x4: CGFloat = 882    // right
    
    // MARK: UIUpdate
    
    func updateUIAfterJsonRequestLocation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            self.ui_location_name.text = self.SelectedLocationTransformedFromJson.name
            self.ui_location_dimension.text = self.SelectedLocationTransformedFromJson.dimension
            self.ui_location_type.text = self.SelectedLocationTransformedFromJson.type
        }
    }

    func updateUIAfterJsonRequestCharacter() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            self.ui_character_name.text = "    " + self.SelectedCharacterTransformedFromJson.name
            self.ui_character_status.text = self.SelectedCharacterTransformedFromJson.status
            self.ui_character_species.text = self.SelectedCharacterTransformedFromJson.species
            self.ui_character_origin.text = self.SelectedCharacterTransformedFromJson.origin
            self.ui_character_lastlocation.text = self.SelectedCharacterTransformedFromJson.location
            self.ui_character_image.image = UIImage(data: self.SelectedCharacterTransformedFromJson.imageData)
        }
    }
    
    func updateUIAfterJsonRequestEpisode() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            self.ui_episodes_name.text = self.SelectedEpisodeTransformedFromJson.name
            self.ui_episodes_airdate.text = self.SelectedEpisodeTransformedFromJson.air_date
            self.ui_episodes_episode.text = self.SelectedEpisodeTransformedFromJson.episode
        }
    }
    
    private func showLocationView() {
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 1, delay: 0.3, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.4, options: [], animations: {
            self.ui_view_location.frame.origin.x = self.x2
            self.ui_view_character.frame.origin.x = self.x3
            self.ui_view_episode.frame.origin.x = self.x4
        }) { (true) in
            self.currentViewDisplayed = .location
            self.maKingANewResquestForResidents()
            self.view.isUserInteractionEnabled = true
        }
        
    }
    
    private func showCharacterView() {
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 1, delay: 0.3, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.4, options: [], animations: {
            self.ui_view_location.frame.origin.x = self.x1
            self.ui_view_character.frame.origin.x = self.x2
            self.ui_view_episode.frame.origin.x = self.x3
        }) { (true) in
            self.currentViewDisplayed = .character
            self.view.isUserInteractionEnabled = true
        }
    }
    
    private func showEpisodeView() {
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 1, delay: 0.3, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.4, options: [], animations: {
            self.ui_view_location.frame.origin.x = self.x0
            self.ui_view_character.frame.origin.x = self.x1
            self.ui_view_episode.frame.origin.x = self.x2
        }) { (true) in
            self.currentViewDisplayed = .episode
            self.view.isUserInteractionEnabled = true
        }
    }
        
    private func cleanLocationView() {
        ui_location_name.text = ""
        ui_location_type.text = ""
        ui_location_dimension.text = ""
    }
    
    private func cleanCharacterView() {
        ui_character_name.text = ""
        ui_character_status.text = ""
        ui_character_species.text = ""
        ui_character_origin.text = ""
        ui_character_lastlocation.text = ""
        ui_character_image.image = nil
    }
           
    private func cleanEpisodeView() {
        ui_episodes_name.text = ""
        ui_episodes_airdate.text = ""
        ui_episodes_episode.text = ""
    }
    
    
    // MARK: VIEWs & Sender
    
    func showViewAccordingToTag(withSender sender: UIButton) {
        
        switch sender.tag {
        case 1:
            ui_button_origin_right.alpha = 0
            ui_button_location_right.alpha = 0
            getSelectedLocation(withLocation: Int.random(in: 1...76), completion: print("location research showV"))
            showLocationView()
        case 2:
            getSelectedCharacter(withID: Int.random(in: 1...493), completion: print("character research showV"))
            showCharacterView()
        case 3:
            ui_button_origin_right.alpha = 0
            ui_button_location_right.alpha = 0
            getSelectedEpisode(withEpisode: Int.random(in: 1...31), completion: print("episode research showV"))
            showEpisodeView()
        case 4:
            ui_button_origin_right.alpha = 0
            ui_button_location_right.alpha = 0
            getSelectedLocationWithString(withString: SelectedCharacterTransformedFromJson.locationURL)
            showLocationView()
        case 5:
            ui_button_origin_right.alpha = 0
            ui_button_location_right.alpha = 0
            getSelectedLocationWithString(withString: SelectedCharacterTransformedFromJson.originURL)
            showLocationView()
        default:
            print("wtf happend again")
        }
    }
    
    func animeSameViewWithSender(withSender sender: UIButton) {
        self.view.isUserInteractionEnabled = false
        
        func selfAnimeView(withView view: UIView) {
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: [], animations: {
                view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                view.frame.origin = CGPoint(x: 207, y: 643)
                view.alpha = 0
                
            }) { (true) in
                UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: [], animations: {
                    view.transform = .identity
                    view.frame.origin = CGPoint(x: 54, y: 110)
                    view.alpha = 1
                }, completion: {
                    (true) in
                    self.view.isUserInteractionEnabled = true
                })
            }
            
        }
        
        switch sender.tag {
        case 1:
            getSelectedLocation(withLocation: Int.random(in: 1...76), completion: print("location research sameV"))
            cleanLocationView()
            selfAnimeView(withView: ui_view_location)
            showLocationView()
        case 2:
            getSelectedCharacter(withID: Int.random(in: 1...493), completion: print("character research sameV"))
            selfAnimeView(withView: ui_view_character)
        case 3:
            getSelectedEpisode(withEpisode: Int.random(in: 1...31), completion: print("episode reearch sameV"))
            selfAnimeView(withView: ui_view_episode)
        default:
            print("whos there ?")
        }
    }
    
    
    func animTheFirstTouchedWithSender(withSender sender: UIButton) {
        
        if currentViewDisplayed == .none {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
                self.ui_RickAndMortyImage.frame.origin.y = -180
            }) { (true) in
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                    self.ui_view_character.frame.origin.y = 110
                    self.ui_view_episode.frame.origin.y = 110
                    self.ui_view_location.frame.origin.y = 110
                }) { (true) in
                    UIView.animate(withDuration: 1) {
                        self.ui_button_origin_right.alpha = 1
                        self.ui_button_location_right.alpha = 1
                    }
                    
                    switch sender.tag {
                    case 1:
                        self.ui_button_origin_right.alpha = 0
                        self.ui_button_location_right.alpha = 0
                        self.getSelectedLocation(withLocation: Int.random(in: 1...76), completion: print("get selected location"))
                        self.showLocationView()
                    case 2:
                        self.getSelectedCharacter(withID: Int.random(in: 1...493), completion: print("get selected character"))
                        self.showCharacterView()
                    case 3:
                        self.ui_button_origin_right.alpha = 0
                        self.ui_button_location_right.alpha = 0
                        self.getSelectedEpisode(withEpisode: Int.random(in: 1...31), completion: print("get selected episode"))
                        self.showEpisodeView()
                    default:
                        print("wtf just happened")
                    }
                }
            }
        } else {
            print("nothing happened here, why do you read ? ")
        }
      
    }
    
    // MARK: Viewloaded & Setup
    
    override func viewWillAppear(_ animated: Bool) {
        ui_button_origin_right.alpha = 0
        ui_button_location_right.alpha = 0
        setupButtons()
        setupInitialScreen()
        ui_tableview_residents.dataSource = self
    }
    
    func handlingButtonFromViewState() {
        switch currentViewDisplayed {
        case .none:
            ui_button_location_right.alpha = 1
            ui_button_origin_right.alpha = 1
            ui_button_origin_right.isUserInteractionEnabled = false
            ui_button_location_right.isUserInteractionEnabled = false
        case .character:
            ui_button_characters.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            ui_button_episodes.layer.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            ui_button_locations.layer.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            ui_button_location_right.layer.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            ui_button_origin_right.layer.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            ui_button_location_right.alpha = 1
            ui_button_origin_right.alpha = 1
            ui_button_origin_right.isUserInteractionEnabled = true
            ui_button_location_right.isUserInteractionEnabled = true
        case .episode:
            ui_button_characters.layer.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            ui_button_episodes.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            ui_button_locations.layer.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            ui_button_location_right.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            ui_button_origin_right.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            ui_button_location_right.alpha = 0
            ui_button_origin_right.alpha = 0
            ui_button_origin_right.isUserInteractionEnabled = false
            ui_button_location_right.isUserInteractionEnabled = false
        case .location:
            ui_button_characters.layer.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            ui_button_episodes.layer.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            ui_button_locations.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            ui_button_location_right.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            ui_button_origin_right.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            ui_button_location_right.alpha = 0
            ui_button_origin_right.alpha = 0
            ui_button_origin_right.isUserInteractionEnabled = false
            ui_button_location_right.isUserInteractionEnabled = false
        }
    }
    
    func setupButtons() {
        
        ui_button_location_right.layer.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        ui_button_location_right.layer.borderWidth = 7
        ui_button_location_right.clipsToBounds = true
        ui_button_location_right.layer.cornerRadius = 15
        
        ui_button_origin_right.layer.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        ui_button_origin_right.layer.borderWidth = 7
        ui_button_origin_right.clipsToBounds = true
        ui_button_origin_right.layer.cornerRadius = 15

        
        ui_button_characters.layer.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        ui_button_characters.layer.borderWidth = 7
        ui_button_characters.clipsToBounds = true
        ui_button_characters.layer.cornerRadius = 15
        ui_button_characters.setTitleColor(#colorLiteral(red: 0.3354646564, green: 0.8334619403, blue: 1, alpha: 1), for: UIControl.State.normal)
        ui_button_characters.backgroundColor = #colorLiteral(red: 0.9429915547, green: 0.918956697, blue: 0.4866940379, alpha: 1)
        ui_button_characters.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)        
        
        ui_button_episodes.layer.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        ui_button_episodes.layer.borderWidth = 7
        ui_button_episodes.clipsToBounds = true
        ui_button_episodes.layer.cornerRadius = 15
        ui_button_episodes.setTitleColor(#colorLiteral(red: 0.3354646564, green: 0.8334619403, blue: 1, alpha: 1), for: UIControl.State.normal)
        ui_button_episodes.backgroundColor = #colorLiteral(red: 0.9429915547, green: 0.918956697, blue: 0.4866940379, alpha: 1)
        ui_button_episodes.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        ui_button_locations.layer.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        ui_button_locations.layer.borderWidth = 7
        ui_button_locations.clipsToBounds = true
        ui_button_locations.layer.cornerRadius = 15
        ui_button_locations.setTitleColor(#colorLiteral(red: 0.3354646564, green: 0.8334619403, blue: 1, alpha: 1), for: UIControl.State.normal)
        ui_button_locations.backgroundColor = #colorLiteral(red: 0.9429915547, green: 0.918956697, blue: 0.4866940379, alpha: 1)
        ui_button_locations.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
    }
    
    func setupInitialScreen() {
        
        ui_view_character.frame.origin = CGPoint(x: 54, y: 863)
        ui_view_location.frame.origin = CGPoint(x: -360, y: 863)
        ui_view_episode.frame.origin = CGPoint(x: 468, y: 863)
       
        ui_RickAndMortyImage.alpha = 1
        ui_RickAndMortyImage.frame.origin.y = 320
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.ui_button_episodes.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (true) in
            UIView.animate(withDuration: 0.5, animations: {
                self.ui_button_episodes.transform = .identity
            }, completion: nil)
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
           self.ui_button_characters.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (true) in
           UIView.animate(withDuration: 0.5, animations: {
                self.ui_button_characters.transform = .identity
            }, completion: nil)
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.ui_button_locations.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (true) in
            UIView.animate(withDuration: 0.5, animations: {
                self.ui_button_locations.transform = .identity
            }, completion: nil)
        }
       
    }
    
    // MARK: ACTION BUTTONS
    
    @IBAction func UIButton_Characters(_ sender: UIButton) {
        
        if currentViewDisplayed == .none {
            animTheFirstTouchedWithSender(withSender: sender)
        } else if currentViewDisplayed == .character {
            cleanCharacterView()
            animeSameViewWithSender(withSender: sender)
        } else {
            showViewAccordingToTag(withSender: sender)
            cleanEpisodeView()
            cleanLocationView()
            cleanCharacterView()
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.6, options: [], animations: {
            self.ui_button_characters.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { (true) in
            self.ui_button_characters.transform = .identity
        }
      
    }
    
    @IBAction func UIButton_Episodes(_ sender: UIButton) {
        
        if currentViewDisplayed == .none {
              animTheFirstTouchedWithSender(withSender: sender)
        } else if currentViewDisplayed == .episode {
            cleanEpisodeView()
            animeSameViewWithSender(withSender: sender)
        } else {
            showViewAccordingToTag(withSender: sender)
            cleanLocationView()
            cleanCharacterView()
            cleanEpisodeView()
        }
    
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.6, options: [], animations: {
            self.ui_button_episodes.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { (true) in
            self.ui_button_episodes.transform = .identity
        }
    
    }
    
    @IBAction func UIButton_Locations(_ sender: UIButton) {
        
        if currentViewDisplayed == .none {
            animTheFirstTouchedWithSender(withSender: sender)
        } else if currentViewDisplayed == .location {
            cleanLocationView()
            animeSameViewWithSender(withSender: sender)
        } else {
            showViewAccordingToTag(withSender: sender)
            cleanCharacterView()
            cleanEpisodeView()
            cleanLocationView()
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.6, options: [], animations: {
            self.ui_button_locations.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { (true) in
            self.ui_button_locations.transform = .identity
        }

    }
    @IBAction func UIButton_Origin(_ sender: UIButton) {
        
        if currentViewDisplayed == .character {
            cleanLocationView()
            showViewAccordingToTag(withSender: sender)
        } else {
            print("Hewlo!")
        }
        
    }
    @IBAction func UIButton_lastLocation(_ sender: UIButton) {
        
        if currentViewDisplayed == .character {
            cleanLocationView()
            showViewAccordingToTag(withSender: sender)
        } else {
            print("Hewlooo!")
        }

    }
    
    
    // MARK: MAIN HTTP
    
    func getRangedOfCharacterWithString(withString stringURL: String){
        RangedCharactersTransformedFromJson = []
        
        if let url = URL(string: stringURL) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    
                    do {
                        let res = try JSONDecoder().decode([JSonRangedCharacters].self, from: data)
                        
                        self.RangedCharactersTransformedFromJson.append(contentsOf: res)
                                                                    
                        print(self.RangedCharactersTransformedFromJson)
                    } catch let error {
                        print(error)
                    }
                    DispatchQueue.main.async {
                        self.ui_tableview_residents.reloadData()
                    }
                    self.updateUIAfterJsonRequestLocation()
                }
            }.resume()
        }
        
    }
    
    func getSelectedLocationWithString(withString stringURL: String) {
        
        if let url = URL(string: stringURL) {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    
                    do {
                        let res = try JSONDecoder().decode(JSonSelectedLocation.self, from: data)
                        self.SelectedLocationTransformedFromJson.name = res.name
                        self.SelectedLocationTransformedFromJson.dimension = res.dimension
                        self.SelectedLocationTransformedFromJson.type = res.type
                        self.SelectedLocationTransformedFromJson.residents = res.residents
                        self.SelectedLocationTransformedFromJson.id = res.id
                     
                    } catch let error {
                        print(error)
                    }
                    self.updateUIAfterJsonRequestLocation()
                }
            }.resume()
        }
        
    }
    
    func getSelectedLocation(withLocation location: Int, completion: Void) { // 76 locations
   
        if let url = URL(string: "https://rickandmortyapi.com/api/location/\(location)") {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(JSonSelectedLocation.self, from: data)
                        self.SelectedLocationTransformedFromJson.name = res.name
                        self.SelectedLocationTransformedFromJson.dimension = res.dimension
                        self.SelectedLocationTransformedFromJson.type = res.type
                        self.SelectedLocationTransformedFromJson.residents = res.residents
                        self.SelectedLocationTransformedFromJson.id = res.id
                        
                        
                    } catch let error {
                        print(error)
                    }
                    self.updateUIAfterJsonRequestLocation()
                }
            
            }.resume()
        }

    }
    
    func getSelectedCharacter(withID id: Int, completion: Void) { // 493 characters
        
        if let url = URL(string: "https://rickandmortyapi.com/api/character/\(id)") {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                
                    do {

                        let res = try JSONDecoder().decode(JSonSelectedCharacter.self, from: data)
                       
                        self.SelectedCharacterTransformedFromJson.image = res.image
                        
                        if let data = try? Data(contentsOf: URL(string: self.SelectedCharacterTransformedFromJson.image)!) {
                            self.SelectedCharacterTransformedFromJson.imageData = data
                        }
                        
                        self.SelectedCharacterTransformedFromJson.name = res.name
                        self.SelectedCharacterTransformedFromJson.status = res.status
                        self.SelectedCharacterTransformedFromJson.species = res.species
                        self.SelectedCharacterTransformedFromJson.type = res.type
                        self.SelectedCharacterTransformedFromJson.gender = res.gender
                        self.SelectedCharacterTransformedFromJson.origin = res.origin.name
                        self.SelectedCharacterTransformedFromJson.location = res.location.name
                        self.SelectedCharacterTransformedFromJson.originURL = res.origin.url
                        self.SelectedCharacterTransformedFromJson.locationURL = res.location.url
                        
                        
                    } catch let error {
                        print(error)
                    }
                    self.updateUIAfterJsonRequestCharacter()
                }
            
            }.resume()
        }
    }
    
    func getSelectedEpisode(withEpisode episode: Int, completion: Void) { // 31 episodes
    
        if let url = URL(string: "https://rickandmortyapi.com/api/episode/\(episode)") {
           
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                
                    do {
                    
                        let res = try JSONDecoder().decode(JSonSelectedEpisode.self, from: data)
                       
                        self.SelectedEpisodeTransformedFromJson.name = res.name
                        self.SelectedEpisodeTransformedFromJson.air_date = res.air_date
                        self.SelectedEpisodeTransformedFromJson.character = res.characters
                        self.SelectedEpisodeTransformedFromJson.episode = res.episode
                        
                    } catch let error {
                        print(error)
                    }
                    self.updateUIAfterJsonRequestEpisode()
                }
            }.resume()
        }
    }
    
    // MARK: SMALL HHTPS

    var newStringNumber: String = ""
    var newUrlRequestCharacters: String = ""
    
    func maKingANewResquestForResidents() {
        newStringNumber = ""
        newUrlRequestCharacters = ""
        
        print("making a new request")
        for url in SelectedLocationTransformedFromJson.residents {
            let lastInt = url.filter { "0"..."9" ~= $0 }
            newStringNumber.append(lastInt + ",")
        }
        newUrlRequestCharacters = "https://rickandmortyapi.com/api/character/\(newStringNumber)"
        print(newUrlRequestCharacters)
        
        getRangedOfCharacterWithString(withString: newUrlRequestCharacters)
        
    }
}

//
//  DataImage.swift
//  QuizzAll
//
//  Created by Nicolas Richard on 04/05/2020.
//  Copyright © 2020 Nicolas Richard. All rights reserved.
//

import Foundation

struct DataImage {
    
//    static let URL_Hubble_one = Bundle.main.url(forResource: "hubble_one", withExtension: "jpg")
//    static let URL_Earth_one = "https://upload.wikimedia.org/wikipedia/commons/c/ca/The_Blue_Marble_4463x4163.jpg"
    
    static var NASA: Dictionary<String,URL> = {
        
        let NASAURLStrings = [
            "French Overseas Region of Guadeloupe" : "https://www.nasa.gov/sites/default/files/thumbnails/image/iss063e002083.jpg",
            "The Idriss Dam in Morocco" : "https://www.nasa.gov/sites/default/files/thumbnails/image/iss063e002302.jpg",
            "Canadas Wanapitei Lake" : "https://www.nasa.gov/sites/default/files/thumbnails/image/iss063e002471.jpg",
            "The Northern Central Portion of Morocco" : "https://www.nasa.gov/sites/default/files/thumbnails/image/iss063e002389.jpg",
            "The Errachidia Provinc of Morocco" : "https://www.nasa.gov/sites/default/files/thumbnails/image/iss063e002398.jpg",
            "Moroccan Province of Guercif" : "https://www.nasa.gov/sites/default/files/thumbnails/image/iss063e002345.jpg",
            "Canadas Lake Nipissing" : "https://www.nasa.gov/sites/default/files/thumbnails/image/iss063e002575.jpg",
            "Staten Island and the New Jersey metropolitan area" : "https://www.nasa.gov/sites/default/files/thumbnails/image/iss063e003768.jpg",
            "The New York/New Jersey metropolitan area" : "https://www.nasa.gov/sites/default/files/thumbnails/image/iss063e003814.jpg",
            "San Diego Bay in California" : "https://www.nasa.gov/sites/default/files/thumbnails/image/iss063e002902.jpg",
            "Space Station Crew Snaps an Image of the Susquehanna River" : "https://www.nasa.gov/sites/default/files/thumbnails/image/iss061e098033_lrg.jpg",
            "An Otherworldly-Looking Bombetoka Bay, Madagascar" : "https://www.nasa.gov/sites/default/files/thumbnails/image/bombetoka_aster_23aug00_lrg.jpg"
        ]
        
        var urls = Dictionary<String,URL>()
        
        for (key, value) in NASAURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
    
}

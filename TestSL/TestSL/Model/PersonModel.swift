//
//  PersonModel.swift
//  TestSL
//
//  Created by Giulio Mignemi on 12/02/21.
//

import UIKit
import SwiftyJSON

class PersonModel {

    var name : String?
    var imageStr : String?
    var urlImage : URL?
    var height : String?
    var mass : String?
    var hair_color : String?
    var skin_color : String?
    var eye_color : String?
    var birth_year : String?
    var gender : String?
    var urlStr : String?
    var films : [FilmModel] = []
    var vehicles : [VehicleModel] = []
    
    static func serializeJSON(json : JSON)->PersonModel{
        let p = PersonModel()
        
        p.name = json["name"].string
        p.height = json["height"].string
        p.mass = json["mass"].string
        p.hair_color = json["hair_color"].string
        p.skin_color = json["skin_color"].string
        p.eye_color = json["eye_color"].string
        p.birth_year = json["birth_year"].string
        p.gender = json["gender"].string
        p.urlStr = json["url"].string
        
        if let url = p.urlStr{
            let char = url.getOnlyNumbers
            print("charID " + char)
            p.imageStr = "https://mobile.aws.skylabs.it/mobileassignments/swapi/" + char + ".png"
        }else{
            p.imageStr = "https://mobile.aws.skylabs.it/mobileassignments/swapi/placeholder.png"
        }
        for film in json["films"].arrayValue{
            if let urlStr = film.string{
                ApiManager().getFilms(url: urlStr, person: p)
            }
        }
        
        for vehicle in json["vehicles"].arrayValue{
            if let urlStr = vehicle.string{
                ApiManager().getVehicle(url: urlStr, person: p)
            }
        }
        
        return p
    }
    
    
}


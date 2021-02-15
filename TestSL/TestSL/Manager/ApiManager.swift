//
//  ApiManager.swift
//  TestSL
//
//  Created by Giulio Mignemi on 12/02/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class ApiManager{

    let baseUrl = "http://swapi.dev/api/people/"
    
    func getPeople(page: Int ,closure : @escaping (Bool)->()){
        let url = "http://swapi.dev/api/people/?page=" + "\(page)"
        print(url)
        AF.request(url).responseJSON { (response) in
            if response.response?.statusCode == 404{
                print("no more page")
                closure(true)
            }
            if let data = response.data{
                if let json = try? JSON(data: data){
                    for res in json["results"]{
                        let person = PersonModel.serializeJSON(json: res.1)
                        DataManager.shared.allPeople.append(person)
                    }
                    closure(false)
                }else{
                    print("error ApiManager getPeople()")
                    closure(false)
                }
            }
        }
    }
    
    func searchPeopleWithName(_ name : String, closure : @escaping ()->()){
        let url = "https://swapi.dev/api/people/?search=" + name
        AF.request(url).responseJSON { (response) in
            if let data = response.data{
                if let json = try? JSON(data: data){
                    print(json)
                    for res in json["results"]{
                        let person = PersonModel.serializeJSON(json: res.1)
                        DataManager.shared.searchedPeople.append(person)
                    }
                    closure()
                }
            }else{
                print("error ApiManager getPeople()")
                closure()
            }
        }
    }
    
    func getFilms(url : String , person : PersonModel){
        AF.request(url).responseJSON { (response) in
            if let data = response.data{
                if let json = try? JSON(data: data){
                    let film = FilmModel().serializeJSON(json: json)
                    person.films.append(film)
                }
            }
        }
    }
    
    func getVehicle(url : String , person : PersonModel){
        AF.request(url).responseJSON { (response) in
            if let data = response.data{
                if let json = try? JSON(data: data){
                    let vehicle = VehicleModel().serializeJSON(json: json)
                    person.vehicles.append(vehicle)
                }
            }
        }
    }
    
}

//
//  VehicleModel.swift
//  TestSL
//
//  Created by Giulio Mignemi on 12/02/21.
//

import UIKit
import SwiftyJSON

class VehicleModel{

    var name : String?
    var model : String?
    var manufacturer : String?
    var cost_in_credits : String?
    var length : Float?
    
    func serializeJSON(json : JSON)->VehicleModel{
        let v = VehicleModel()
        
        v.name = json["name"].string
        v.model = json["model"].string
        v.manufacturer = json["manufacturer"].string
        v.cost_in_credits = json["cost_in_credits"].string
        v.length = json["length"].float
        
        
        return v
    }
}

//
//  VehicleCollectionViewCell.swift
//  TestSL
//
//  Created by Giulio Mignemi on 15/02/21.
//

import UIKit

class VehicleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var prodLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var lenghtLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setCell(vehicle : VehicleModel){
        layer.cornerRadius = 15
        nameLabel.text = vehicle.name
        prodLabel.text = vehicle.manufacturer
        modelLabel.text = vehicle.model
        if let len = vehicle.length{
            lenghtLabel.text = "Lenght : \(len)"
        }else{
            lenghtLabel.text = ""
        }
        priceLabel.layer.cornerRadius = 15
        priceLabel.clipsToBounds = true
        if vehicle.cost_in_credits == "unknown"{
            priceLabel.text = "N/D"
        }else{
            priceLabel.text = vehicle.cost_in_credits
        }
        
    }
    
}

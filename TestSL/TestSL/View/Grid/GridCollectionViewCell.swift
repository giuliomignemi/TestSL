//
//  GridCollectionViewCell.swift
//  TestSL
//
//  Created by Giulio Mignemi on 15/02/21.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var gridImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    func setCell(person : PersonModel){
        if let urlOk = person.imageStr{
            if let url = URL(string: urlOk){
                gridImageView.af.setImage(withURL: url) { (image) in
                    if let data = image.data{
                        if let imageOk = UIImage(data: data){
                            person.urlImage = url
                        }else{
                            if let url = URL(string: "https://mobile.aws.skylabs.it/mobileassignments/swapi/placeholder.png"){
                                self.gridImageView.af.setImage(withURL: url)
                                person.imageStr = "https://mobile.aws.skylabs.it/mobileassignments/swapi/placeholder.png"
                            }
                        }
                    }
                }
            }
        }
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        clipsToBounds = true
        nameLabel.text = person.name
    }
    
}

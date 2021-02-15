//
//  ListTableViewCell.swift
//  TestSL
//
//  Created by Giulio Mignemi on 12/02/21.
//

import UIKit
import AlamofireImage

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(person : PersonModel){
        personImageView.layer.cornerRadius = 10
        personImageView.layer.borderColor = UIColor.gray.cgColor
        personImageView.layer.borderWidth = 1
        if let urlOk = person.imageStr{
            if let url = URL(string: urlOk){
                personImageView.af.setImage(withURL: url) { (image) in
                    if let data = image.data{
                        if let imageOk = UIImage(data: data){
                            person.urlImage = url
                        }else{
                            if let url = URL(string: "https://mobile.aws.skylabs.it/mobileassignments/swapi/placeholder.png"){
                                self.personImageView.af.setImage(withURL: url)
                                person.imageStr = "https://mobile.aws.skylabs.it/mobileassignments/swapi/placeholder.png"
                            }
                        }
                    }
                }
            }
        }
        nameLabel.text = person.name
    }

}

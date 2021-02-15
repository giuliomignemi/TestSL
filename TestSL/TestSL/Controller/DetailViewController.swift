//
//  DetailViewController.swift
//  TestSL
//
//  Created by Giulio Mignemi on 14/02/21.
//

import UIKit

class DetailViewController: UITableViewController {
    
    @IBOutlet weak var persImageView: UIImageView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var filmsCollectioView: UICollectionView!
    @IBOutlet weak var vehicleCollectionView: UICollectionView!
    
    
    
    
    
    var person : PersonModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    func setUI(){
        guard let personOk = person else{return}
        if let urlImg = personOk.imageStr, let url = URL(string: urlImg){
            persImageView.af.setImage(withURL: url)
        }
        blurView.layer.cornerRadius = blurView.layer.frame.size.height / 2
        nameLabel.text = personOk.name
        heightLabel.text = "Height: " + personOk.height!
        massLabel.text = "Mass: " + personOk.mass!
        genderLabel.text = "Gender: " + personOk.gender!
        hairColorLabel.text = "Hair Color: " + personOk.hair_color!
    }
    
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 357
        case 1:
            return 138
        case 2:
            return 225
        case 3:
            if person!.vehicles.count == 0{
                return 0
            }else{
                return 225
            }
        default:
            return 0
        }
    }


}



extension DetailViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let personOk = person else{return 0}
        if collectionView == filmsCollectioView{
            return personOk.films.count
        }else{
            return personOk.vehicles.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let personOk = person else{return UICollectionViewCell()}
        if collectionView == filmsCollectioView{
            let cell = filmsCollectioView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FilmCollectionViewCell
            cell.setCell(film: personOk.films[indexPath.row])
            return cell
        }else{
            let cell = vehicleCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VehicleCollectionViewCell
            cell.setCell(vehicle: personOk.vehicles[indexPath.row])
            return cell
        }
    }
    
    
}

//
//  FilmCollectionViewCell.swift
//  TestSL
//
//  Created by Giulio Mignemi on 15/02/21.
//

import UIKit

class FilmCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    
    
    func setCell(film : FilmModel){
        layer.cornerRadius = 15
        titleLabel.text = film.title
        dateLabel.text = film.release_date
        descrLabel.text = film.opening_crawl
    }
    
}

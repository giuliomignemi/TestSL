//
//  FilmModel.swift
//  TestSL
//
//  Created by Giulio Mignemi on 12/02/21.
//

import UIKit
import SwiftyJSON

class FilmModel{

    var title : String?
    var opening_crawl : String?
    var release_date : String?
    
    
    func serializeJSON(json : JSON)->FilmModel{
        let f = FilmModel()
        
        f.title = json["title"].string
        f.opening_crawl = json["opening_crawl"].string
        f.release_date = json["release_date"].string
        
        return f
    }
}

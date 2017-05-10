//
//  DataToMovie.swift
//  Movies
//
//  Created by Matthew on 5/10/17.
//  Copyright © 2017 Matthew. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataToMovie {
    static func buildMovies(json: JSON) -> [Movie] {
        var results: [Movie] = []
        let searchResults = json["Search"]
        
        for (_, movie) in searchResults {
            let id = movie["imdbID"].string
            let title = movie["Title"].string
            let year = movie["Year"].string
            let imageUrl = movie["Poster"].string
            
            results.append(Movie(id: id!, title: title!, year: year!, imageUrl: imageUrl!))
        }
        
        return results;
    }
}

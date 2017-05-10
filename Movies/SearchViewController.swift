//
//  SearchViewController.swift
//  Movies
//
//  Created by Matthew on 5/9/17.
//  Copyright © 2017 Matthew. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var searchText: UITextField!
    @IBOutlet var searchTabelView: UITableView!
    
    var searchResults: [Movie] = []
    
    @IBAction func search(sender: UIButton) {
        var searchTerm = searchText.text!
        
        if searchTerm.characters.count >= 3 {
            getMoviesBySearchTerm(term: searchTerm)
        }
    }
    
    func getMoviesBySearchTerm(term: String) -> Void {
        // @TODO set up http req, parse JSON, map resp to a Movie
        let url = "https://omdbapi.com/?s=\(term)&type=movie&r=json"
        
        HTTPHandler.getJson(url: url, completionHandler: parseMovieData)
    }
    
    func parseMovieData(data: Data?) -> Void {
        if let data = data {
            let json: JSON = JSON(data)
            
            DataToMovie.buildMovies(json: json)
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Search Results"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        let index = indexPath.row
        
        movieCell.favButton.tag = index
        
        movieCell.movieTitle?.text = searchResults[index].title
        movieCell.movieYear?.text = searchResults[index].year
        
        ViewController.displayMovieImage(index, cell: movieCell, store: searchResults)
        
        return movieCell
    }
    
    // grouped vertical sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ViewController.swift
//  Movies
//
//  Created by Matthew on 5/9/17.
//  Copyright © 2017 Matthew. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var mainTableView: UITableView!
    
    // store array of Movies to display
    var favoriteMovies: [Movie] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchViewSegue" {
            let controller = segue.destination as! SearchViewController
            
            // this could be named anything, set the ViewController to be the delegate
            // property on the SearchViewController
            controller.delegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! CustomTableViewCell
        
        let index: Int = indexPath.row
        let title: String = favoriteMovies[index].title
        let year:  String = favoriteMovies[index].year
        
        movieCell.movieTitle.text = title
        movieCell.movieYear.text = year
        
        ViewController.displayMovieImage(index, cell: movieCell, store: favoriteMovies)
        
        return movieCell
    }
    
    // reused in SearchViewController
    static func displayMovieImage(_ row: Int, cell: CustomTableViewCell, store: [Movie]) {
        let url: String = (URL(string: store[row].imageUrl)?.absoluteString)!
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {(data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async(execute: {
                let image = UIImage(data: data!)
                cell.movieImageView.image = image
            })
        }).resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainTableView.reloadData()
        if favoriteMovies.count == 0 {
            favoriteMovies.append(Movie(id: "fooobarMovie", title: "Star Wars", year: "2005", imageUrl: "https://s-media-cache-ak0.pinimg.com/236x/31/09/d1/3109d18cff56e5e03bd349b518d51aeb.jpg", plot: "Death Star but it's a planet!!!"))
        }
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


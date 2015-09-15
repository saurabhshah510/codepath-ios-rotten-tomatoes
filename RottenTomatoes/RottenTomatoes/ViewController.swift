//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by Saurabh Shah on 9/12/15.
//  Copyright © 2015 Saurabh Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    let CELL_NAME = "com.codepath.rottentomatoes.moviecell"
    @IBOutlet weak var movieTableView: UITableView!
    var movies: [NSDictionary]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5")
        let request = NSURLRequest(URL: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary
            if responseDictionary != nil{
                self.movies = responseDictionary!["movies"] as? [NSDictionary]
                self.movieTableView.reloadData()
            }            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.movies != nil{
            return self.movies!.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCellWithIdentifier(CELL_NAME) as! MovieCell
        if (self.movies != nil && self.movies!.count != 0) {
            let movie = self.movies![indexPath.row]
            movieCell.movieLabel.text = movie["title"] as? String
        }
        return movieCell
    }

}

class MovieCell: UITableViewCell{
    
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}
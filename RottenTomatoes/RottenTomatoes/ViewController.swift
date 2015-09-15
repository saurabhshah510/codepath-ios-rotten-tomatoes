//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by Saurabh Shah on 9/12/15.
//  Copyright © 2015 Saurabh Shah. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let CELL_NAME = "com.codepath.rottentomatoes.moviecell"
    @IBOutlet weak var movieTableView: UITableView!
    
    @IBOutlet weak var networkErrorLabel: UILabel!
    var movies: [NSDictionary]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.networkErrorLabel.hidden = true
        let url = NSURL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5")
        let request = NSURLRequest(URL: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if error == nil{
                self.networkErrorLabel.hidden = true
                let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary
                if responseDictionary != nil{
                    self.movies = responseDictionary!["movies"] as? [NSDictionary]
                    self.movieTableView.reloadData()                
                }
            } else{
                self.networkErrorLabel.hidden = false
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
            movieCell.descriptionLabel.text = movie["synopsis"] as? String
            let url = NSURL(string: movie.valueForKeyPath("posters.thumbnail") as! String)!
            movieCell.posterView.setImageWithURL(url)
        }
        return movieCell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! MovieCell
        let indexPath = movieTableView.indexPathForCell(cell)
        let movie = self.movies![indexPath!.row]
        let movieDetailsViewController = segue.destinationViewController as! MovieDetailsViewController
        movieDetailsViewController.movie = movie        
    }

}

class MovieCell: UITableViewCell{
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}

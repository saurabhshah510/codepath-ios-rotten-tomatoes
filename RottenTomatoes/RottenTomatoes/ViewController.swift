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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCellWithIdentifier(CELL_NAME) as! MovieCell
        movieCell.movieLabel.text = "Fast and Furious \(indexPath.row)"
        return movieCell
    }

}

class MovieCell: UITableViewCell{
    
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}

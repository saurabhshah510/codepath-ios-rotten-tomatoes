//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by Saurabh Shah on 9/14/15.
//  Copyright © 2015 Saurabh Shah. All rights reserved.
//

import UIKit
import AFNetworking

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    var movie: NSDictionary!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = self.movie["title"] as? String
        synopsisLabel.text = self.movie["synopsis"] as? String
        let url = NSURL(string: movie.valueForKeyPath("posters.thumbnail") as! String)!
        imageView.setImageWithURL(url)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

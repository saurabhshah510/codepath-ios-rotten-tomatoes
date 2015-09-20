//
//  DVDViewController.swift
//  RottenTomatoes
//
//  Created by Saurabh Shah on 9/19/15.
//  Copyright © 2015 Saurabh Shah. All rights reserved.
//

import UIKit
import AFNetworking
import JTProgressHUD

class DVDViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let CELL_NAME = "DVDCell"
    @IBOutlet weak var DVDTableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    var dvds: [NSDictionary]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        DVDTableView.insertSubview(refreshControl, atIndex: 0)
        makeApiCall()
        
        // Do any additional setup after loading the view.
    }
    
    func onRefresh() {
        makeApiCall()
    }
    
    func makeApiCall(){
        JTProgressHUD.show()
        let url = NSURL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/current_releases.json?apikey=dagqdghwaq3e3mxyrp7kmmj5")
        let request = NSURLRequest(URL: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if error == nil{
                let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary
                if responseDictionary != nil{
                    self.dvds = responseDictionary!["movies"] as? [NSDictionary]
                }
            }else{
                
            }
            self.DVDTableView.reloadData()
            self.refreshControl.endRefreshing()
            JTProgressHUD.hide()
        }
        
        //in call back
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if self.dvds != nil{
            return self.dvds!.count
        }else{
            return 0
        }
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let dvdCell = tableView.dequeueReusableCellWithIdentifier(CELL_NAME, forIndexPath: indexPath) as! DVDTableViewCell
        if (self.dvds != nil && self.dvds!.count != 0){
            let dvd = self.dvds![indexPath.row]
            let url = NSURL(string: dvd.valueForKeyPath("posters.thumbnail") as! String)!
            dvdCell.dvdImageView.setImageWithURL(url)
            dvdCell.titleLabel.text = dvd["title"] as? String
            dvdCell.synopsisLabel.text = dvd["synopsis"] as? String
            
        }
        return dvdCell
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

class DVDTableViewCell: UITableViewCell{
    
    @IBOutlet weak var dvdImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
}


//
//  PhotosViewController.swift
//  Drinkr
//
//  Created by William Wettersten on 2/4/15.
//  Copyright (c) 2015 William Wettersten. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var photos: NSArray! = []

    var refreshControl : UIRefreshControl!

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 320
        tableView.delegate = self
        tableView.dataSource = self

        self.refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "fetch:", forControlEvents: .ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        fetch(refreshControl)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("PhotoViewCell") as PhotoViewCell
        
        var url = photos[indexPath.row].valueForKeyPath("images.low_resolution.url") as String
        cell.imgView.setImageWithURL(NSURL(string: url))
        
        return cell
    }

    func fetch(sender: UIRefreshControl) {
        var clientId = "ce1848d0d33e4833b0ca6beac05ac210"
        
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(clientId)")!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            self.photos = responseDictionary["data"] as NSArray
            
            self.tableView.reloadData()
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as PhotoDetailsViewController
        
        var indexPath:NSIndexPath = tableView.indexPathForCell(sender as UITableViewCell)!
        
        vc.selected = photos[indexPath.row] as? NSDictionary
    }

}

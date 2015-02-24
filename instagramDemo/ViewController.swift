//
//  ViewController.swift
//  instagramDemo
//
//  Created by Vinod Sirimalle on 2/17/15.
//  Copyright (c) 2015 vs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var photos: [NSDictionary]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 320
        
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=ed9f6ceacbc3476199174244f579e073")!
        
        var request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            
            self.photos = dictionary["data"] as [NSDictionary]
            println("photos: \(self.photos)")
            self.tableView.reloadData()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell") as PhotoCell
        
        var photo = photos[indexPath.row]
        var images = photo["images"] as NSDictionary
        var lowResImage = images["low_resolution"] as NSDictionary
       var url = lowResImage["url"] as String
    
       cell.photoView.setImageWithURL(NSURL(string: url))
        
        return cell
    }

}

